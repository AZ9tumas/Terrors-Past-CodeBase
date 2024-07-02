-- Get the required services and modules
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DinosaurService = require(script.Parent.Parent.Dinosaur)

-- Other modules
local m_GrowthHandler = require(script.Parent:WaitForChild("Growth"))
local m_Dinosaur = require(script.Parent.Parent:WaitForChild("Dinosaur"))

local morph = {}

-- Objects from ReplicatedStorage
local BodyMovers = ReplicatedStorage:WaitForChild("BodyMovers")
local BodyPosition = BodyMovers:WaitForChild("BodyPosition")
local AngularVelocity = BodyMovers:WaitForChild("AngularVelocity")

-- Folders and other instances
local Dinosaurs = ServerStorage.Models
local DinosaurScripts = script.Parent:WaitForChild("DinosaurScripts")
local CombatScripts : Folder = script.Parent:WaitForChild("CombatClient")

-- Function to initialize the player's attributes
function morph.init(Player : Player)
    -- Set initial attribute values for swimming, stamina, and hunger
    Player.Swimming.Value = false
    Player.Stamina.Value = 1
    Player.Hunger.Value = 1

    -- Reset the attributes on the player
    morph.ResetAttributes(Player)

    -- Return 1 to indicate successful initialization
    return 1
end

function morph.GetMass(model : Model)
    -- Calculate mass of the given model
	local mass = 0;

	for _, v in pairs(model:GetDescendants()) do
		if (v:IsA("BasePart")) then mass += v.AssemblyMass; end
	end

    return mass
end

function morph.ResetAttributes(Player : Player)
    -- Set dinosaur related attributes to nil
    Player:SetAttribute("Dinosaur", nil)
    Player:SetAttribute("Type", nil)
    Player:SetAttribute("Gender", nil)
    Player:SetAttribute("Growth", nil)
    Player:SetAttribute("Mass", nil)

    -- Set stats related attributes to nil
    Player:SetAttribute("Stamina", nil)
    Player:SetAttribute("Hunger", nil)
    Player:SetAttribute("Loaded", nil)
    Player:SetAttribute("GrowthTimeStamp", nil)

    -- Reset the walkspeeds
    Player:SetAttribute("DashSpeed", nil)
    Player:SetAttribute("RunSpeed", nil)
    Player:SetAttribute("Speed", nil)
    Player:SetAttribute("CrouchSpeed", nil)

    return 1
end

-- Function to set up the player's attributes
function morph.SetUpAttributes(Player : Player, dtype : string, dinoName : string, gender : string, growth : string)

    -- Set player attributes based on the provided parameters
    Player:SetAttribute("Dinosaur", dinoName)
    Player:SetAttribute("Type", dtype)

    gender = gender or DinosaurService.DecideDinosaurGender(Player)
    growth = growth or m_GrowthHandler.GetGrowthStatus(Player)

    Player:SetAttribute("Gender", gender)
    Player:SetAttribute("Growth", growth)

    -- Retrieve stats based on the player's dinosaur
    local stats = DinosaurService.GetStatsFromPlayer(Player)

    -- Set additional attributes based on retrieved stats
    Player:SetAttribute("Stamina", stats.Stamina)
    Player:SetAttribute("Hunger", stats.Hunger)
    Player:SetAttribute("Loaded", false)
    Player:SetAttribute("GrowthTimeStamp", nil)

    -- Set the walkspeeds

    local d_stats = m_Dinosaur.GetStatsFromPlayer(Player)

    Player:SetAttribute("DashSpeed", d_stats.DashSpeed)
    Player:SetAttribute("RunSpeed", d_stats.RunSpeed)
    Player:SetAttribute("Speed", d_stats.Speed)
    Player:SetAttribute("CrouchSpeed", d_stats.CrouchSpeed)

    -- Return 1 to indicate successful attribute setup
    return 1
end

-- Function to clone and morph the player's character
function morph.Clone(Player : Player)
    -- Retrieve the necessary attributes for cloning
    local dinoName : string = Player:GetAttribute("Dinosaur")
    local dtype : string = Player:GetAttribute("Type")
    local gender : string = Player:GetAttribute("Gender")
    local growth : string = Player:GetAttribute("Growth")

    -- Retrieve the required dinosaur model
    local requiredModel : Model = Dinosaurs[dtype][dinoName][gender][growth][dinoName]

    local lastCFrame = Player.Character and Player.Character.HumanoidRootPart.CFrame or workspace.MapTerrain.Etc.teleport1.CFrame

    -- Clone the model and set it as the player's character
    local newModel : Model = requiredModel:Clone()
    newModel.Name = Player.Name
    Player.Character = newModel
    newModel.Parent = workspace

    -- Put the new character in the map
    newModel:PivotTo(lastCFrame)
    if workspace.StreamingEnabled then
        Player:RequestStreamAroundAsync(newModel.HumanoidRootPart.Position)
    end

    -- Set the mass
    local mass = morph.GetMass(newModel)
    Player:SetAttribute("Mass", mass)

    -- Make a static version of the head, and name it "Hitbox"
    local HumanoidRootPart = Player.Character:WaitForChild("HumanoidRootPart")
    local Head = Player.Character:WaitForChild("Head")

    local hitbox = Instance.new("Part", Player.Character)
    hitbox.Name = "Hitbox"
    hitbox.CFrame = Head.CFrame
    hitbox.Transparency = 0.7
    hitbox.Size = Head.Size

    -- Weld this to the humanoid
    local weld = Instance.new("WeldConstraint", HumanoidRootPart)
    weld.Part0 = hitbox
    weld.Part1 = HumanoidRootPart

    -- Return 1 to indicate successful cloning and morphing
    return 1
end

-- Function to set up body movers for the player's character
function morph.SetupBodyMovers(Player: Player)
    -- Retrieve the player's humanoid root part
    local HumanoidRootPart = Player.Character.HumanoidRootPart

    -- Set up attachment for turning orientation
    local attachment = Instance.new('Attachment', HumanoidRootPart)
    attachment.Name = 'TurnOrientationAttachment'
    attachment.CFrame = CFrame.new(0,0,0)
    attachment.WorldCFrame = HumanoidRootPart.CFrame
    attachment.Visible = false

    -- Set up angular velocity for turning
    local newAngularVelocity : AngularVelocity = AngularVelocity:Clone()
    newAngularVelocity.Parent = HumanoidRootPart
    newAngularVelocity.Name = 'TurnVelocity'
    newAngularVelocity.Attachment0 = attachment
    newAngularVelocity.MaxTorque = DinosaurService.GetStatsFromPlayer(Player).TurnTorque

    -- Set up body position for swimming
    local newBodyPosition : BodyPosition = BodyPosition:Clone()
    newBodyPosition.Parent = HumanoidRootPart
    newBodyPosition.MaxForce = Vector3.zero

    -- Return 1 to indicate successful setup of body movers
    return 1
end

-- Function to attach scripts to the player's character
function morph.AttachScripts(Player : Player)
    -- Find or create the Handlers folder in the player's character
    local scripts = Player.Character:FindFirstChild("Handlers") or
        Instance.new("Folder", Player.Character)
    scripts.Name = "Handlers"
    scripts:ClearAllChildren()

    -- Clone and attach the scripts from DinosaurScripts folder
    for _, sc : Script | LocalScript | ModuleScript in pairs(DinosaurScripts:GetChildren()) do
        -- Skip if the object is not a script or module script
        if not table.find(
            {"ModuleScript", "Script", "LocalScript"},
            sc.ClassName
        ) then continue end

        -- Clone and attach the script/module script
        local new = sc:Clone()
        new.Parent = scripts
    end

    -- Get the combat scripts
    local dinoName = Player:GetAttribute("Dinosaur")
    local combatDetails = m_Dinosaur.GetStatsFromDinosaurName(dinoName, "Combat")
    print("Combat details: ", combatDetails)

    -- Retrieve the respective scripts
    for attackType : string, attackName : string in pairs(combatDetails) do
        local req_script = CombatScripts:FindFirstChild(attackName)
        print(attackName, req_script)

        local reqBindableFunction : BindableFunction = Instance.new("BindableFunction", scripts)
        reqBindableFunction.Name = attackType.."Bindable"
        
        if not req_script then continue end

        local new = req_script:Clone()
        new.Name = attackType
        new.Parent = scripts
    end

    -- Enable the LocalScript
    scripts.LocalScript.Enabled = true
    
    -- Require the SwimModule script
    require(scripts.SwimModule)

    -- Return 1 to indicate successful attachment of scripts
    return 1
end

-- Return the morph module
return morph
