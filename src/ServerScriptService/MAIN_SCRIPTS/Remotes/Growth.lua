local GrowthHandler = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local m_DinosaurDivisions = require(ReplicatedStorage:WaitForChild("DinosaurDivisions"))

-- Methods
function GrowthHandler.GetGrowthStatus(Player : Player)
    local DinosaurName = Player:GetAttribute("Dinosaur")
    local DinosaurId = m_DinosaurDivisions.GetIndex(DinosaurName)

    local DinosaurType = Player:GetAttribute("Type")
    local Indexes = Player:GetAttribute(DinosaurType)
    local GrowthStages = m_DinosaurDivisions.GetGrowthStagesFromIndexes(Indexes)

    --print(GrowthStages, DinosaurId)

    return GrowthStages[DinosaurId]
end

return GrowthHandler