local module = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Bindables
local Bindables = ReplicatedStorage:WaitForChild("Bindable")
local Set = Bindables:WaitForChild("Set")

-- Helper functions
function changeLetterAtIndex(str, index, newLetter)
    local pattern = "(%a)(%d+)"
    local letter, number = str:match(pattern, index)
    
    if letter and number then
        return str:gsub(pattern, function(matchLetter, matchNumber)
            if matchLetter == letter and tonumber(matchNumber) == tonumber(number) then
                return newLetter .. matchNumber
            end
            return matchLetter .. matchNumber
        end)
    end
    
    return str
end

-- Modules
local m_DinosaurStats = require(script.Parent.Parent:WaitForChild("Dinosaur"))
local m_RemoteHandler = require(script.Parent.Parent:WaitForChild("RemoteEventHandler"))
local m_DinosaurDivisions = require(ReplicatedStorage:WaitForChild("DinosaurDivisions"))

function module.HandleGrowth(Player : Player)
    -- If we hit this timestamp, we know that it's time to grow the player
    -- In case there's a missing timestamp, set it to baby again

    -- First, get the timestamp, and some other information

    local timeStamp = Player:GetAttribute("GrowthTimeStamp")
    local dinosaurName = Player:GetAttribute("Dinosaur")
    local dinosaurType = Player:GetAttribute("Type")

    local currentGrowthStage = Player:GetAttribute("Growth")
    
    if currentGrowthStage == "Adult" then return end
    if not dinosaurName or not dinosaurType then return end

    -- We need to get the player's growth rate based on it's current growth stage.
    local dinoStats = m_DinosaurStats.GetStatsFromPlayer(Player)
    local _next = dinoStats.GrowthRate * 60

    -- If the timeStamp is nil, we have to set it

    if not timeStamp then

        timeStamp = tick() + _next
        Player:SetAttribute("GrowthTimeStamp", timeStamp)
    end

    -- Now, the timestamp definitely exisits
    -- Find out if it's time to grow the player
    
    if timeStamp - tick() <= 0 then
        -- It's time to grow the player
        -- Reset time stamp, and depend on the above statements to set it back
        Player:SetAttribute("GrowthTimeStamp", nil)
        Player.GrowthPercentage.Value = 0
        return module.GrowPlayer(Player)
    end

    -- Set the growth percentage
    Player.GrowthPercentage.Value = (1 - (timeStamp - tick()) / _next) * 100
end

function module.GrowPlayer(Player : Player, GrowthStage : string)
    local GrowthStage : string = GrowthStage or Player:GetAttribute("Growth")
    local DinosaurName : string = Player:GetAttribute("Dinosaur")
    local DinosaurType : string = Player:GetAttribute("Type")
    local Gender : string = Player:GetAttribute("Gender")

    local newGrowthStage : string = GrowthStage == "Baby" and "Juvenile" or GrowthStage == "Juvenile" and "Adult" or "Adult"
    
    m_RemoteHandler:MenuReset(Player)
    m_RemoteHandler:Morph(Player, DinosaurName, DinosaurType, Gender, newGrowthStage)
    
    Player:SetAttribute("Loaded", true)

    -- changing and saving data
    local indexes = Player:GetAttribute(DinosaurType)
    local dinoID = m_DinosaurDivisions.GetIDFromIndex(m_DinosaurDivisions.GetIndex(DinosaurName))
    local newIndexes = changeLetterAtIndex(indexes, dinoID, newGrowthStage:sub(1, 1):lower())

    Player:SetAttribute(DinosaurType, newIndexes)
    Set:Fire(Player, DinosaurType, newIndexes)

    Player.leaderstats.Points.Value += math.random(50, 100)
end

return module