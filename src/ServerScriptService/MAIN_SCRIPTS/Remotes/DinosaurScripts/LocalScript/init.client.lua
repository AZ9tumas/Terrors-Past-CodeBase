-- [[ RBX SCRIPT CONNECTIONS LINKER ]]
-- Create a table to store script connections
local Connections: {RBXScriptConnection} = {}

-- [[ SERVICES ]]
-- Get the required services
local SocialService = game:GetService("SocialService")
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")

-- [[ OTHER MODULES ]]
-- Import other required modules
local m_MechanicHandler = require(script:WaitForChild("Mechanic"))
local m_NightVisionHandler = require(script:WaitForChild("NightVision"))
local m_CombatConnector = require(script:WaitForChild("CombatConnector"))

-- Initialize some modules quickly
m_MechanicHandler.init()

-- [[ PLAYER PARAMS ]]
-- Get the local player
local Player = game.Players.LocalPlayer
repeat task.wait() until script.Parent.Parent:IsA("Model")
repeat task.wait() until Player:GetAttribute("Loaded") == true

-- [[ CHARACTER PARAMS ]]
-- Get the character and humanoid of the local player
local Character = script.Parent.Parent
local Humanoid : Humanoid = Character:WaitForChild('Humanoid')
-- Enable controls
m_MechanicHandler.Controls(true)

-- [[ ROAR INFORMATION ]]
-- Define the roar key bindings and their corresponding actions
local RoarLinker = {
	[Enum.KeyCode.One] = "Roar",
	[Enum.KeyCode.Two] = "Passive",
	[Enum.KeyCode.Three] = "Threat",
}

-- Connection for handling user input when a key is pressed
local InputBeginRBXConnection = UserInputService.InputBegan:Connect(function (input : InputObject, gameProcessedEvent : boolean)
	if gameProcessedEvent then return end
	
	-- Check if the pressed key corresponds to a roar action
	if RoarLinker[input.KeyCode] then
		m_MechanicHandler.Roar(RoarLinker[input.KeyCode])

	elseif input.KeyCode == Enum.KeyCode.X then
		-- Toggle dashing state and call the corresponding mechanic handler function
		
		-- If the player isn't able to dash, return
		if Player.Stamina.Value <= 0 then return end

		if table.find(m_MechanicHandler.Keys, Enum.KeyCode.X) then
			-- Stop dashing
			table.remove(m_MechanicHandler.Keys, table.find(m_MechanicHandler.Keys, Enum.KeyCode.X))
		else
			-- Start dashing
			table.insert(m_MechanicHandler.Keys, Enum.KeyCode.X)
		end
		m_MechanicHandler.HandleMechanic()
		
	elseif input.KeyCode == Enum.KeyCode.N then
		-- Toggle night vision state and call the corresponding night vision handler function
		m_NightVisionHandler.Toggle(not m_NightVisionHandler.NightVision)

	elseif input.KeyCode == Enum.KeyCode.R then
		-- Toggle resting state and call the corresponding mechanic handler function
		m_MechanicHandler.Rest(not m_MechanicHandler.isResting)

	elseif table.find(m_MechanicHandler.SpecialKeys, input.KeyCode) then
		-- Handle other important keys by calling the mechanic handler function

		-- Some of these events aren't allowed in certain cases
		if Player.Stamina.Value <= 0 then return end

		table.insert(m_MechanicHandler.Keys, input.KeyCode)
		m_MechanicHandler.HandleMechanic()
	end

	if not m_MechanicHandler.isResting then
	
		m_CombatConnector.CheckInputType(input)
	end
end)

-- Connection for handling user input when a key is released
local InputEndedRBXConnection = UserInputService.InputEnded:Connect(function (input : InputObject, gameProcessedEvent : boolean)
	if gameProcessedEvent then return end
	
	if table.find(m_MechanicHandler.SpecialKeys, input.KeyCode) then 
		-- Handle release of important keys by calling the mechanic handler function

		if table.find(m_MechanicHandler.Keys, input.KeyCode) then
			table.remove(m_MechanicHandler.Keys, table.find(m_MechanicHandler.Keys, input.KeyCode))
		end
		m_MechanicHandler.HandleMechanic()
	end
end)

-- Connection for handling running state change of the humanoid
local HumanoidRunningRBXConnection = Humanoid.Running:Connect(function() m_MechanicHandler.HandleMechanic() end)

-- Connection for handling proximity prompt triggered events
local ProximityPromptTriggeredRBXConnection = ProximityPromptService.PromptTriggered:Connect(function(Prompt : ProximityPrompt, InputType : Enum.ProximityPromptInputType)
	-- Eating will disable controls, so call the mechanic handler function for eating
	m_MechanicHandler.Eat(Prompt)
end)

-- Store all the script connections in the Connections table
Connections = {InputBeginRBXConnection, InputEndedRBXConnection, HumanoidRunningRBXConnection, ProximityPromptTriggeredRBXConnection}

-- Function to clean up script connections
local function clean_up()
	-- Disconnect all script connections
	for _, connection : RBXScriptConnection in pairs(Connections) do
		connection:Disconnect()
	end

	if m_MechanicHandler.isResting then m_MechanicHandler.Rest(false) end

	-- Clean up the mechanic handler
	m_MechanicHandler.Clean()
end

-- Connection for handling when the humanoid dies
table.insert(Connections, Humanoid.Died:Connect(clean_up))

-- Connection for handling when the player's character is removed
table.insert(Connections, Player.CharacterRemoving:Connect(clean_up))