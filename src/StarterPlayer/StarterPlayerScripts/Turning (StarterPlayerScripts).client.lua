local Players = game:GetService("Players")

local inertiaModule = require(game.ReplicatedStorage:WaitForChild("JointInertia"))

inertiaModule:Init()

local activePlayers = {}

local function addChar(char)
	char:WaitForChild("HumanoidRootPart")
	task.wait(2)
	inertiaModule:Add(char)
end

Players.PlayerAdded:Connect(function(player)
	local newPlayer = {}
	newPlayer.Instance = player
	newPlayer.CharacterAddedConnection = player.CharacterAdded:Connect(function(char)
		addChar(char)
	end)
	activePlayers[player.Name] = newPlayer
end)

Players.PlayerRemoving:Connect(function(player)
	if player ~= Players.LocalPlayer then
		activePlayers[player.Name].CharacterAddedConnection:Disconnect()
		activePlayers[player.Name].CharacterAddedConnection = nil
		activePlayers[player.Name] = nil
	end
end)

Players.LocalPlayer.CharacterAdded:Connect(function(char)
	addChar(char)
end)

Players.LocalPlayer.CharacterRemoving:Connect(function(char)
	inertiaModule:Remove(char)
end)