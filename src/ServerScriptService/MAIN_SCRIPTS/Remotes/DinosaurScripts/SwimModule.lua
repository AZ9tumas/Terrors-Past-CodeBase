-- Create the module
local module = {}

-- Get the required services and objects
local ServerScriptService = game:GetService("ServerScriptService")

-- Import the DinosaurStats module
local m_DinosaurStats = require(ServerScriptService.MAIN_SCRIPTS.Dinosaur)

-- Get the character and humanoid of the dinosaur
local Character = script.Parent.Parent
local Humanoid : Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Get the body position which is used to move the dinosaur while swimming
local BodyPosition : BodyPosition = HumanoidRootPart:WaitForChild("BodyPosition")

-- Get the player associated with the dinosaur
local Player = game.Players:GetPlayerFromCharacter(Character)

-- Get the mass of the dinosaur (used for physics calculations)
local mass = Player:GetAttribute("Mass")
local maxforce : Vector3 = Vector3.new(0, workspace.Gravity * mass, 0)

-- Get the swim speed of the dinosaur from its stats
local SwimSpeed = m_DinosaurStats.GetStatsFromPlayer(Player).SwimSpeed

-- Variables to track the water the dinosaur is currently in
local CurrentWaterpart = nil
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = {workspace.Terrain}
params.IgnoreWater = false

-- Event connections to handle swimming
HumanoidRootPart.Touched:Connect(function(part)
    if part and part.Name:lower() == "water" then
        Player.Swimming.Value = true
        CurrentWaterpart = part
    end
end)

HumanoidRootPart.TouchEnded:Connect(function(part)
    if part and part.Name:lower() == "water" then
        Player.Swimming.Value = false
        CurrentWaterpart = nil
    end
end)

-- Coroutine to handle swimming behavior
coroutine.wrap(function()
    while wait() do
        -- Check if the dinosaur is swimming and in water
        if Player.Swimming.Value and CurrentWaterpart then
            -- Set the dinosaur's walk speed to the swim speed
            Humanoid.WalkSpeed = SwimSpeed
            
            -- Calculate the Y position of the water surface
            local CalculatedYvalue = CurrentWaterpart.Position.Y + (CurrentWaterpart.Size.Y / 2)
            local calculatedpos = Vector3.new(0, CalculatedYvalue, 0)
            
            -- Apply physics-based swimming using BodyPosition
            BodyPosition.MaxForce = maxforce
            BodyPosition.Position = calculatedpos
        else
            -- Reset the BodyPosition force when not swimming
            BodyPosition.MaxForce = Vector3.new(0, 0, 0)
        end
    end
end)()

-- Return the module
return module
