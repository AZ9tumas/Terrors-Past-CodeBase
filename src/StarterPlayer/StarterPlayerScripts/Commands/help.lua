local module = {}

-- Modules
local m_AutoComplete = require(script.Parent.Parent.TerminalHandler.Autocomplete)

module.Description = "use this command to view the usage and purpose of all other commands"

module.Params = {m_AutoComplete.AUTOCOMPLETE_TYPE_COMMANDS}

function module.run(params)
    -- Only one param is expected (optional)
    -- If we do receive this parameter, it's type will be a "command"

    if #params == 0 then
        -- Get all the commands' descriptions
        local desc = {}
        for _, v in pairs(script.Parent:GetChildren()) do
            table.insert(desc, v.Name .. " - " .. require(v).Description)
        end

        return 1, desc
    elseif #params == 1 then
        -- Get the specific command
        local spec = script.Parent:FindFirstChild(params[1])
        if not spec then return 2, 'HelpError: Unknown identifier "' .. params[1] .. '"' end

        return 1, spec.Name .. " - " .. require(spec).Description
    else
        return 2, "HelpError: Expected only one parameter, got " .. #params
    end
end

return module