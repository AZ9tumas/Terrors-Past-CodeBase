--[[
    Required by both server and clients
    This module is used to create prompts which can be used to interact with objects in the game.

    Primary use of this system as of now is to eat and drink.

    Eating ::
        -> Prompts will be setup on the client, and these prompts will enable the player to interact with their respective food items,
        based on their dinosaur diet.

    Drinking ::
        -> Every water part will have a range equal to half of it's size + delta amount, so players can drink the water at any point on the shore.
        -> This system allows players to drink WHILE swimming too.
    
    -> It might be that the prompt is disabled for a few seconds after every interaction.
]]

local CollectionService = game:GetService("CollectionService")

local module = {}

function module.CreatePrompt(ParentInstance : Instance, n : number)

    -- Get the required prompts and put them under the instance given.
    -- The instances will be either meatparts or treeparts.

    local prompt = Instance.new("ProximityPrompt")
    prompt.Name = "Interact"
    prompt.Parent = ParentInstance
    prompt.HoldDuration = 2
    prompt.Style = Enum.ProximityPromptStyle.Custom
    prompt.MaxActivationDistance = n or 10

    return prompt
end

return module