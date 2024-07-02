local module = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Remotes
local Remotes : Folder = ReplicatedStorage:WaitForChild("Remotes")
local Morph : RemoteFunction = Remotes:WaitForChild("ChangeDino")
local Loaded : RemoteEvent = Remotes:WaitForChild("Loaded")

-- Scripts
local s_Util = ReplicatedStorage:WaitForChild("DinosaurStatsUtilityModule")

-- Modules
local m_AutoComplete = require(script.Parent.Parent.TerminalHandler.Autocomplete)
local m_Util = require(s_Util)

module.Description = "morph into a dinosaur"
module.Params = {m_AutoComplete.AUTOCOMPLETE_TYPE_DINOSAURS}

function module.run(params)
    -- Expect one parameter, which is the player name

    if #params ~= 1 or not s_Util:FindFirstChild(params[1]) then
        return 0, "MorphError: Expected a valid dinosaur name"
    end

    local success, msg

    pcall(function()
        success, msg = Morph:InvokeServer(params[1], m_Util.getDinosaurType(params[1]))
        Loaded:FireServer()
    end)

    return success and 1 or 2, msg or "There was an error in doing that."
end

return module