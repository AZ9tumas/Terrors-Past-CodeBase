local module = {}

local m_Carnivores = require(script.Carnivores)
local m_Herbivores = require(script.Herbivores)
local m_Omnivores = require(script.Omnivores)
local m_Util = require(script.Parent.DinosaurStatsUtilityModule)

module.Branches = {
	Carnivores = m_Carnivores,
	Herbivores = m_Herbivores,
	Omnivores = m_Omnivores
}

function module.GetBranchingDinosaur(DinosaurName)
	local obj = module.GetDinosaurObject(DinosaurName)
	return obj.Predecessors[1].Name
end

function module.ScanSuccessors(DinosaurObj, property, val)
	if DinosaurObj[property] == val then return DinosaurObj end
	for i, v in pairs(DinosaurObj.Successors) do
		local scan = module.ScanSuccessors(v, property, val)
		if scan then return scan end
	end
end

function module.GetDinosaurObject(DinosaurName : string)
	local DinoType = m_Util.getDinosaurType(DinosaurName)
	local tree = module.Branches[DinoType]
	-- parse tree for dinosaurname
	local obj = module.ScanSuccessors(tree, 'Name', DinosaurName)
	return obj
end

function module.GetIndex(DinosaurName : string)
	return module.GetDinosaurObject(DinosaurName).Index
end

function module.GetDinosaur(index : number, dinotype : string)
	local tree = module.Branches[dinotype]
	-- parse tree again
	local obj = module.ScanSuccessors(tree, 'Index', index)
	return obj.Name
end

function module.GetGrowthStatusFromIndex(index : string) : string
	local c = string.sub(index, 1, 1)

	local s = {
		["b"] = "Baby",
		["j"] = "Juvenile",
		["a"] = "Adult"
	}

	return s[c] or "Baby"
end

function module.GetIDFromIndex(index : string) : number
	-- check if the index works accordingly
	local first = string.sub(index, 1, 1)
	if table.find({"a", "b", "j"}, first) then
		-- new system
		return tonumber(string.sub(index, 2, #index))
	else
		return tonumber(index)
	end
end

function module.GetDinosaursFromIndexes(dinotype : string, indexes : string)
	local dinos = {}
	for _, v in pairs(indexes:split("-")) do
		table.insert(dinos, module.GetDinosaur(module.GetIDFromIndex(v), dinotype))
	end
	return dinos
end

function module.GetGrowthStage(Player : Player, DinosaurName : string)
	local dinosaurType = m_Util.getDinosaurType(DinosaurName)
	local indexes = Player:GetAttribute(dinosaurType)
	local stages = module.GetGrowthStagesFromIndexes(indexes)
	local index = module.GetIDFromIndex(module.GetIndex(DinosaurName))

	return stages[index]
end

function module.GetGrowthStagesFromIndexes(indexes : string)
	local stages = {}

	for _, v in indexes:split("-") do
		stages[module.GetIDFromIndex(v)] = module.GetGrowthStatusFromIndex(v)
	end

	return stages
end

return module
