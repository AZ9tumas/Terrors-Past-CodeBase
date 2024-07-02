-- Create the DinosaurInformationModule table
local DinosaurInformationModule = {}

--[[ SERVICES ]]

local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- [[ REMOTES ]]
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local GetModel : RemoteFunction = Remotes:WaitForChild("GetModel")

function DinosaurInformationModule:SetUp()
	if not RunService:IsServer() then return warn("Nope.") end
	script:ClearAllChildren()
	
	-- Models kept in Server Storage
	local Models = ServerStorage:WaitForChild("Models")
	
	-- Iterate over each dinosaur type in the Models folder
	for _, dinoType in pairs(Models:GetChildren()) do
		-- Iterate over each dinosaur name in the current dinosaur type folder
		for _, dinoName in pairs(dinoType:GetChildren()) do
			local folder = Instance.new("Folder", script)
			folder.Name = dinoName.Name

			local val = Instance.new("StringValue")
			val.Value = dinoType.Name
			val.Name = dinoName.Name
			val.Parent = folder

			local cost = Instance.new("NumberValue", folder)
			local reqScript = ServerScriptService.Dinosaurs[dinoType.Name]:FindFirstChild(dinoName.Name)

			cost.Value = reqScript and require(reqScript).Stats["Points"] or 1000
			cost.Name = "Cost"
		end
	end
end

-- Function to retrieve the dinosaur type from the given name
function DinosaurInformationModule.getDinosaurType(name)
	return script:FindFirstChild(name) and script[name][name].Value
end

-- Function to retrieve the stats of a dinosaur based on its type
-- Note: This function might be removed soon.
function DinosaurInformationModule.getDinosaurStats(dinosaurName)
	-- Retrieve the stats (e.g., walkspeed, sprinting speed, etc.) based on the dinosaur type
	-- Return the corresponding stats for the given type
	
	return "lol"
end

-- Function to retrieve the model of a dinosaur based on its name
function DinosaurInformationModule.getDinosaurModel(dinosaurName)
	-- This function has been closed
	if true then return end
	
	-- Retrieve the model
	local requiredModel = GetModel:InvokeClient(DinosaurInformationModule.getDinosaurType(dinosaurName), dinosaurName)
	if not requiredModel then return warn("Something went wrong, please try again later.", requiredModel) end
	
	print("Successfully retrieved the model.", requiredModel)
	return requiredModel
end

-- Function to retrieve the cost of a dinosaur based on its name
function DinosaurInformationModule.getDinosaurCost(dinosaurName : string)
	return script:FindFirstChild(dinosaurName) and script[dinosaurName]["Cost"].Value
end

-- Return the DinosaurInformationModule table
return DinosaurInformationModule
