local module = {}

-- Modules
local m_AutoComplete = require(script.Parent.Parent.TerminalHandler.Autocomplete)

module.Description = "view the account age of a player"

module.Params = {m_AutoComplete.AUTOCOMPLETE_TYPE_PLAYERS}

function module.run(params)
    -- Expect one parameter, which is the player name

    if #params ~= 1 or not game.Players:FindFirstChild(params[1]) then
        return 0, "AccountAgeError: Expected a valid player name"
    end

    local player : Player = game.Players[params[1]]

    return 1, 'Account age of ' .. player.Name .. ' is ' ..player.AccountAge

end

return module