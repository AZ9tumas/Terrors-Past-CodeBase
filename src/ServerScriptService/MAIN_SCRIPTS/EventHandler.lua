local module = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local RedeemFolder : Folder = ServerScriptService:WaitForChild("Redeem")

local Events = ReplicatedStorage:WaitForChild("Remotes")
local RemoteEventMethods = require(script.Parent.RemoteEventHandler)
local Remotes2 = require(script.Parent.Remotes.BuyDinosaur)

local function mec_tst(Player, pos)
	if not Player then return end

	RemoteEventMethods:RunMechanic(Player, pos)
end

Events:WaitForChild("ChangeDino").OnServerInvoke = function(Player, Selected_Dino, dino_type)
	return RemoteEventMethods:Morph(Player, Selected_Dino, dino_type, nil)
end

Events:WaitForChild("Mechanic").OnServerEvent:Connect(mec_tst)

Events:WaitForChild("Footstep").OnServerEvent:Connect(function(a, b, c)
	RemoteEventMethods:OnFootStepCall(a, b, c)
end)

Events:WaitForChild("Roar").OnServerEvent:Connect(function(a,b)RemoteEventMethods:Roar(a,b)end)

Events:WaitForChild("NightVision").OnServerEvent:Connect(function(plr, value)
	RemoteEventMethods:NightVision(plr, value)
end)

Events:WaitForChild("EatorDrink").OnServerEvent:Connect(function(player, m_type, meatPart)
	RemoteEventMethods:EatorDrink(player, m_type, meatPart) 
end)

Events:WaitForChild("GetModel").OnServerInvoke = function(plr, dinoType, dinoName)
	return RemoteEventMethods:GetModel(plr, dinoType, dinoName)
end

Events:WaitForChild("Redeem").OnServerEvent:Connect(function(plr : Player, redeemCode : string)
	if RedeemFolder:FindFirstChild(redeemCode) then
		local requiredScript = require(RedeemFolder:FindFirstChild(redeemCode))
		local success = requiredScript:InvokeCode(plr)
	end
end)

Events:WaitForChild("Loaded").OnServerEvent:Connect(function(plr : Player)
	plr:SetAttribute("Loaded", true)
end)

Events:WaitForChild("MenuReset").OnServerEvent:Connect(function(plr : Player)
	RemoteEventMethods:MenuReset(plr)
end)

Events:WaitForChild("Buy").OnServerInvoke = function(plr, dinoname)
	return Remotes2.BuyDinosaur(plr, dinoname)
end

Events:WaitForChild("LoadAnimations").OnServerInvoke = function(player)
	return RemoteEventMethods:LoadAnims(player)
end

Events:WaitForChild("LookVector").OnServerEvent:Connect(function(plr : Player, newCFrame : CFrame)
	plr:SetAttribute("LookVector", newCFrame)
end)

Events:WaitForChild("Settings").OnServerEvent:Connect(function(plr : Player, settings_param : string, newval : boolean)
	RemoteEventMethods:ChangeSetting(plr, settings_param, newval)
end)

return module
