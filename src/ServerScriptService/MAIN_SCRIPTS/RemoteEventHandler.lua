local module = {}

local NightVisionPlayers = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Bindable = ReplicatedStorage:WaitForChild("Bindable")
local Get : BindableFunction = Bindable:WaitForChild("Get")
local Set : BindableEvent = Bindable:WaitForChild("Set")

local incrementer = script.Parent:WaitForChild("Incrementer"):WaitForChild("IncrementHandler")

local RemoteModules = script.Parent:WaitForChild("Remotes")

local f_CombatServerScripts = ServerScriptService:WaitForChild("CombatServer")
local f_Remotes = ReplicatedStorage:WaitForChild("Remotes")

local m_DinoDivisions = require(ReplicatedStorage:WaitForChild("DinosaurDivisions"))
local m_FootStephandler = require(RemoteModules:WaitForChild("Footsteps"))
local m_AnimationsHandler = require(RemoteModules:WaitForChild("Animation"))
local m_Morph = require(RemoteModules:WaitForChild("Morph"))
local m_Mechanic = require(RemoteModules:WaitForChild("Mechanic"))
local m_GrowthHandler = require(RemoteModules:WaitForChild("Growth"))
local m_BuyDinosaur = require(RemoteModules:WaitForChild("BuyDinosaur"))

local DinosaurModels = ServerStorage:WaitForChild("Models")

-- combat.init

for _, v in pairs(f_CombatServerScripts:GetChildren()) do
	local newEvent = Instance.new("RemoteEvent", f_Remotes)
	newEvent.Name = v.Name

	newEvent.OnServerEvent:Connect(function(player)
		local req = f_CombatServerScripts:FindFirstChild(newEvent.Name)
		require(req).ServerInvoke(player)
	end)
end

function module:AddFootsteps(Model, footstep_type, footstep_volume)
	return m_FootStephandler.HandleFootsteps(Model)
end

function module:OnFootStepCall(Player, FootstepType, GroundType)
	local s, e = pcall(m_FootStephandler.Call, Player, FootstepType, GroundType)

	return s
end

function module:LoadAnims(Player, dino, dino_type)
	return m_AnimationsHandler.Load(Player)
end

function module:Morph(Player : Player, selectedDino : string, creatureType : string, gender : string, growth : string)
	
	local index, _ = m_BuyDinosaur.CheckOwnershipStatus(Player, selectedDino)

	if not index then return false, "You do not own this dinosaur yet." end

	local model = DinosaurModels[creatureType][selectedDino]["Male"]["Baby"]:FindFirstChild(selectedDino)
	if not model then return false, "Dinosaur not available" end

	if Player.Character then
		module:MenuReset(Player)
	end

	m_Morph.init(Player)
	m_Morph.SetUpAttributes(Player, creatureType, selectedDino, gender, growth)
	m_Morph.Clone(Player)
	m_Morph.SetupBodyMovers(Player)
	m_Morph.AttachScripts(Player)

	if NightVisionPlayers[Player] then module:NightVision(Player, false) end
	-- Loading anims and footsteps
	local success =  module:LoadAnims(Player) and module:AddFootsteps(Player.Character)
	
	if success then
		-- save this selection
		Set:Fire(Player, "Selection", Player:GetAttribute("Dinosaur"))
	end
	
	return success, "Successfully morphed into " .. selectedDino
end

function module:RunMechanic(player : Player, pos)
	return m_Mechanic.Run(player, pos)
end

function module:EatorDrink(player : Player, Type : string, meatPart : Part)
	if not player:GetAttribute("Loaded") then return end

	if Type == nil and meatPart == nil then
		local checker = incrementer:FindFirstChild(player.Name)
		if checker then checker:Destroy() end
		return
	end

	-- type is whether the player is eating or drinking
	local Character = player.Character
	local Head = Character:FindFirstChild("Head")
	if not Head then return warn("No head found for this dino.") end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then return warn("No hrp found.") end

	-- check if this is a valid call
	
	if not (meatPart:IsA("Part") or meatPart:IsA("BasePart")) then return end
	if (meatPart.Position - HumanoidRootPart.Position).Magnitude > 5 then return end
	
	local Sound : Sound = Head:FindFirstChild(Type.."ing")
	if not Sound then return warn("No "..Type.." sound found.") end

	local PlayerChecker = Instance.new("Folder", incrementer)
	PlayerChecker.Name = player.Name
	
	Sound:Play()

	if Type == "Eat" then
		local maxHunger : number = player:GetAttribute("Hunger")
		local actualValue : number = player.Hunger.Value * maxHunger
		player.Hunger.Value = math.min(1, (actualValue + 25) / maxHunger)
	end
end

function module:Roar(player:Player, Roartype:string)
	local Character = player.Character
	local Head = Character:FindFirstChild("Head")
	--print(Head)
	if not Head then warn("No head found for this dino.") end

	local Sound : Sound = Head:FindFirstChild(Roartype)
	if not Sound then return warn("No roaring sound found for '", Roartype, "'") end
	local Pitch = Sound:FindFirstChildWhichIsA("PitchShiftSoundEffect") or Instance.new("PitchShiftSoundEffect", Sound)
	Pitch.Octave = ({0.99, 1.00, 1.01})[math.random(1, 3)]
	--print(Pitch, Pitch.Octave)
	Sound:Play()
end

function module:NightVision(Player : Player, enable : boolean)
	local Character = Player.Character
	if not Character then return end
	
	local LeftEye = Character:FindFirstChild("LeftEye")
	if not LeftEye then return warn("No left eye found.") end
	
	local RightEye = Character:FindFirstChild("RightEye")
	if not RightEye then return warn("No Right eye found.") end
	
	if not enable then
		-- disable
		if NightVisionPlayers[Player] then
			-- found info
			local material = NightVisionPlayers[Player][1]
			local decalTransparency = NightVisionPlayers[Player][2]

			LeftEye.Material = material
			RightEye.Material = material

			LeftEye:FindFirstChildWhichIsA("Decal").Transparency = decalTransparency
			RightEye:FindFirstChildWhichIsA("Decal").Transparency = decalTransparency

			NightVisionPlayers[Player] = nil
		end
	else
		-- enable
		local info = {LeftEye.Material, LeftEye:FindFirstChildWhichIsA("Decal").Transparency}
		NightVisionPlayers[Player] = info

		LeftEye.Material = Enum.Material.Neon
		LeftEye:FindFirstChildWhichIsA("Decal").Transparency = 1

		RightEye.Material = Enum.Material.Neon
		RightEye:FindFirstChildWhichIsA("Decal").Transparency = 1
	end
end

function module:GetModel(plr : Player, dinoType : string, dinoName : string)
	
	local IFolder = ServerStorage:FindFirstChild(plr.Name)
	if not IFolder then return warn("No player folder.") end
	
	local indexes = IFolder:FindFirstChild(dinoType)
	if not indexes then return warn("No indexes found.") end
	
	local dinosaurs = m_DinoDivisions:GetDinosaursFromIndexes(dinoType, indexes.Value)
	if not table.find(dinosaurs, dinoName) then return warn("Cannot retrieve that model.") end
	
	local males = DinosaurModels:WaitForChild(dinoType):WaitForChild(dinoName)["Male"]
	local model = males:WaitForChild( m_GrowthHandler.GetGrowthStatus(plr) ):WaitForChild(dinoName)
	
	print(model)
	
	return model
end

function module:GetUnlockedDinosaurs(plr, dinoType, def)
	return Get:Fire(plr, dinoType, def or "b1")
end

function module:MenuReset(player : Player)
	m_Morph.ResetAttributes(player)

	local char = player.Character
	local hum : Humanoid = char:FindFirstChild("Humanoid")
	
	if hum then
		hum.Health = 0
	end

	player.Character = nil
	-- char:Destroy()

	player:SetAttribute("Loaded", false)
end

function module:ChangeSetting(plr : Player, settings_param : string, newVal : boolean)
	plr:SetAttribute("Settings" .. settings_param, newVal)

	local params = {}
	for key, val in pairs(plr:GetAttributes()) do
		if string.find(key, "Settings") then
			params[key] = val
		end
	end

	print("New Params", params)

	Set:Fire(plr, "Settings", params)
end

return module
