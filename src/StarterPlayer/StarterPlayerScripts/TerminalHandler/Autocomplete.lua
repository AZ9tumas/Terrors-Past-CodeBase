local module = {}

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Player
local Player : Player = Players.LocalPlayer

-- UI
local PlayerGUI = Player:WaitForChild("PlayerGui")
local ConsoleUI : ScreenGui = PlayerGUI:WaitForChild("C")

local AutoCompleteFrames : Frame = ConsoleUI:WaitForChild("Autocomplete")
local AutoCompleteScrollingFrame : ScrollingFrame = AutoCompleteFrames:WaitForChild("ScrollingFrame")
local template : TextLabel = AutoCompleteScrollingFrame:WaitForChild("Template")

-- Scripts
local s_UtilHandler = ReplicatedStorage.DinosaurStatsUtilityModule

local Commands = script.Parent.Parent:WaitForChild("Commands")

local commands = {}

for _, v in pairs(Commands:GetChildren()) do
    table.insert(commands, v.Name)
end

-- Autocomplete data types
module.AUTOCOMPLETE_TYPE_COMMANDS = 0
module.AUTOCOMPLETE_TYPE_PLAYERS = 1
module.AUTOCOMPLETE_TYPE_DINOSAURS = 2

function module.ClearScrollingFrame()
    for _, v in pairs(AutoCompleteScrollingFrame:GetChildren()) do
        if v.Name == "Template" then v:Destroy() end
    end
end

function module.setupTokens(token : string, state : number)
    module.ClearScrollingFrame()

    local suggestions = {}

    if state == module.AUTOCOMPLETE_TYPE_COMMANDS then
        suggestions = commands
    elseif state == module.AUTOCOMPLETE_TYPE_PLAYERS then
        for _, x in pairs(game.Players:GetPlayers()) do
            table.insert(suggestions, x.Name)
        end
    elseif state == module.AUTOCOMPLETE_TYPE_DINOSAURS then
        for _, n in pairs(s_UtilHandler:GetChildren()) do
            table.insert(suggestions, n.Name)
        end
    end

    -- get all commands
    local matches = {}
        
    for _, v : string in pairs(suggestions) do
        --print(v:lower():match(token:lower()), v, token)
        if token == nil or string.sub(v:lower(), 1, #token) == token:lower() then
            local newTemplate = template:Clone()
            newTemplate.Text = v
            newTemplate.Parent = AutoCompleteScrollingFrame
            newTemplate.Visible = true

            table.insert(matches, v)
        end
    end

    return matches
end

return module