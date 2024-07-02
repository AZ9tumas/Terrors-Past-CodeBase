-- [[ SERVICES ]]
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- [[ MAIN VARS ]]
local players = game:GetService("Players")
local Folder = ServerScriptService:WaitForChild("MAIN_SCRIPTS")

-- [[ MODULES ]]
local m_DatastoreHandler = require(Folder:WaitForChild("DataStoreHandler"))
local m_RemoteEventHandler = require(Folder:WaitForChild("RemoteEventHandler"))
local m_DinoUtilHandler = require(ReplicatedStorage:WaitForChild("DinosaurStatsUtilityModule"))
local m_Informer = require(Folder:WaitForChild("Remotes"):WaitForChild("Informer"))

-- [[ BINDABLES ]]
local Bindables = ReplicatedStorage:WaitForChild("Bindable")
local SetData : BindableEvent = Bindables:WaitForChild("Set")
local GetData : BindableFunction = Bindables:WaitForChild("Get")
local IncrementData : BindableEvent = Bindables:WaitForChild("Increment")

-- [[ REMOTE FUNCTIONS ]]
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ClientSelection = Remotes:WaitForChild("ClientSelection")

-- [[ require the important modules ]]
m_DinoUtilHandler:SetUp() -- Setup
require(Folder:WaitForChild("EventHandler"))

local function SET_UI(plr)
	for i,ui in pairs(game.ReplicatedFirst:GetChildren()) do
		local newUI = ui:Clone()
		newUI.Parent = plr:WaitForChild("PlayerGui")
	end
end

local function unlocked_dinosaurs_setup(plr : Player)
	-- All of this information is kept under server storage
	
	local InfoFolder = Instance.new("Folder", ServerStorage)
	InfoFolder.Name = plr.Name
	
	for _, v in pairs({ "Carnivores", "Herbivores", "Omnivores", "Pterosaurs" }) do
		local req = Instance.new("StringValue", InfoFolder)
		req.Name = v
		req.Value = m_DatastoreHandler:GetData(plr, v, "b1")
		
		req:GetPropertyChangedSignal("Value"):Connect(function()
			m_DatastoreHandler:SetData(plr, v, req.Value, false)
		end)
	end
end

local function STATS_SETUP(plr : Player)
	local leaderstats = Instance.new("Folder", plr)
	leaderstats.Name = "leaderstats"
	
	local points = Instance.new("IntValue")
	points.Name = "Points"
	points.Value = m_DatastoreHandler:GetData(plr, "Points", 50)
	points.Parent = leaderstats
	
	local swimming = Instance.new("BoolValue", plr)
	swimming.Name = "Swimming"
	swimming.Value = false

	local stamina = Instance.new("NumberValue", plr)
	stamina.Name = "Stamina"
	stamina.Value = 1
	
	local Hunger = Instance.new("NumberValue", plr)
	Hunger.Name = "Hunger"
	Hunger.Value = 1

	local GrowthPercentage = Instance.new("NumberValue", plr)
	GrowthPercentage.Value = 0
	GrowthPercentage.Name = "GrowthPercentage"

	--m_DatastoreHandler:SetData(plr, "Carnivores", "b1")
	plr:SetAttribute("Carnivores", m_DatastoreHandler:GetData(plr, "Carnivores", "b1"))
	plr:SetAttribute("Herbivores", m_DatastoreHandler:GetData(plr, "Herbivores", "b1"))
	plr:SetAttribute("Omnivores", m_DatastoreHandler:GetData(plr, "Omnivores", "b1"))
	plr:SetAttribute("Pterosaurs", m_DatastoreHandler:GetData(plr, "Pterosaurs", "b1"))

	points:GetPropertyChangedSignal("Value"):Connect(function()
		m_DatastoreHandler:SetData(plr, "Points", points.Value, false)-- math.random(0, 1) or false)
	end)
end

local function ATTRIBUTES(plr : Player)
	-- Some important attributes
	-- such as settings parameters

	-- Settings:
	-- 1. Camera Sway
	-- 2. Background Music (Tentative)
	-- 3. Mouse Lock?

	local __settings = m_DatastoreHandler:GetData(plr, "Settings", {
		["SettingsCameraSway"] = false,
		["SettingsBackgroundMusic"] = false
	})

	for key, val in pairs(__settings) do
		plr:SetAttribute(key, val)
	end
end

players.PlayerAdded:Connect(function(plr : Player)
	-- Allowing "Beta testers" and above ranks to play the game
	if plr:GetRankInGroup(5296318) < 4 and not RunService:IsStudio() then
		return plr:Kick('Only "Beta Testers" and above roles are allowed in the game')
	end

	--m_Informer.PostInformation(plr.Name .. " just joined the game.")

	m_DatastoreHandler:LinkPlayer(plr)
	STATS_SETUP(plr)
	unlocked_dinosaurs_setup(plr)
	SET_UI(plr)
	ATTRIBUTES(plr)

	local lastSelection = m_DatastoreHandler:GetData(plr, "Selection", "")
	if lastSelection ~= "" then
		ClientSelection:FireClient(plr, lastSelection)
	end
end)

players.PlayerRemoving:Connect(function(plr)
	m_DatastoreHandler:RemoveLink(plr)
end)

SetData.Event:Connect(function(player : Player, key : string, value : any, saveData : boolean)
	m_DatastoreHandler:SetData(player, key, value, saveData or false)
end)

IncrementData.Event:Connect(function(player : Player, key : string, incr : number)
	m_DatastoreHandler:IncrementData(player, key, incr)
end)

GetData.OnInvoke = function(Player : Player, key : string, defaultVal : any)
	return m_DatastoreHandler:GetData(Player, key, defaultVal)
end