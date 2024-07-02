-- all dinosaur stats retriever

-- Define custom Array type
export type Array <type1, type2> = {[type1] : type2}

-- Get the ReplicatedStorage service
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create the Dinosaur module
local Dinosaur = {}

-- Get the Dinosaurs folder
local Dinosaurs : Folder = script.Parent.Parent:WaitForChild("Dinosaurs")

-- Load the DinosaurStatsUtilityModule for utility functions
local m_statsUtil = require(ReplicatedStorage:WaitForChild("DinosaurStatsUtilityModule"))

-- Function to retrieve dinosaur stats based on the player
function Dinosaur.GetStatsFromPlayer(Player : Player) : Array<string, any>
    -- Retrieve the dinosaur script based on player attributes
    local dinoScript = require(
        Dinosaurs[Player:GetAttribute("Type")][ Player:GetAttribute("Dinosaur") ]
    )

    -- Return the stats based on player growth attribute
    return dinoScript.Stats[Player:GetAttribute("Growth")]
end

-- Function to retrieve dinosaur animations based on the player
function Dinosaur.GetAnimationsFromPlayer(Player : Player) : Array<string, string>
    -- Retrieve the dinosaur script based on player attributes
    local dinoScript = require(
        Dinosaurs[Player:GetAttribute("Type")][ Player:GetAttribute("Dinosaur") ]
    )

    -- Return the animations based on player growth attribute
    return dinoScript.Animations[Player:GetAttribute("Growth")]
end

-- Function to retrieve dinosaur stats based on the dinosaur name and growth attribute
function Dinosaur.GetStatsFromDinosaurName(DinosaurName : string, Growth : string)
    -- Get the dinosaur type based on the dinosaur name
    local dtype = m_statsUtil.getDinosaurType(DinosaurName)

    -- Retrieve the dinosaur script based on dinosaur name and type
    local dinoScript = require(
        Dinosaurs[dtype][DinosaurName]
    )

    -- Return the stats based on growth attribute
    return dinoScript.Stats[Growth]
end

-- Function to retrieve dinosaur animations based on the dinosaur name and growth attribute
function Dinosaur.GetAnimationsFromDinosaurName(DinosaurName : string, Growth : string)
    -- Get the dinosaur type based on the dinosaur name
    local dtype = m_statsUtil.getDinosaurType(DinosaurName)

    -- Retrieve the dinosaur script based on dinosaur name and type
    local dinoScript = require(
        Dinosaurs[dtype][DinosaurName]
    )

    -- Return the animations based on growth attribute
    return dinoScript.Animations[Growth]
end

-- Function to decide the dinosaur gender for a player
function Dinosaur.DecideDinosaurGender(Player : Player)
    -- Generate a random number between 0 and 100
    local r = math.random(0, 100)
    
    -- Retrieve the dinosaur script based on player attributes
    local dinoScript = require(
        Dinosaurs[Player:GetAttribute("Type")][ Player:GetAttribute("Dinosaur") ]
    )

    -- Get the male and female gender chances
    local male = dinoScript.MALE
    local female = dinoScript.FEMALE

    -- Determine the higher chance between male and female
    local higherChance = male > female and male or female

    -- Decide the gender based on the random number and higher chance
    if r > male then
        return higherChance == male and "Female" or "Male"
    else
        return higherChance == male and "Male" or "Female"
    end
end

-- Return the Dinosaur module
return Dinosaur
