local module = {}

module.curr = 0
module.char = nil
module.str = ""

export type Token = {
    Name : string,
    Value : any
}

function module.makeToken(tokenName, tokenValue)
    local newToken : Token = {}
    newToken.Name = tokenName
    newToken.Value = tokenValue

    return newToken
end

-- init function ->
function module.getTokens(str)

    module.curr = 0
    module.char = nil
    module.str = str
    module.advance()

    local tokens, positions = module.Scanstr()

    return {
        Tokens = tokens,
        Positions = positions
    }
end

function module.advance()
    module.curr += 1
    module.char = module.curr <= #module.str and string.sub(module.str, module.curr, module.curr) or nil
    return module.char
end

function module.scan_lexeme() : string
    local lemexe : string = ""

    while module.char and (not string.find(" \n\t\r", module.char, 1, true))
        and (not string.match(module.char, "W%")) do
        -- add
        lemexe ..= module.char
        module.advance()
    end

    return lemexe
end

function module.Scanstr() : {Token}
    -- scan and make tokens

    local tokens : {Token} = {}
    local positions : {number} = {}

    while module.char do
        -- scan char
        if string.find(" \n\t\r", module.char, 1, true) then
            module.advance()
        
        elseif not module.char:match("W%") then
            local c = module.curr
            local l = module.scan_lexeme()
            table.insert(positions, c)
            table.insert(tokens, l)
        
        else
            warn("invalid token found", module.char)
        end
    end

    return tokens, positions
end

return module