-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- Player
local Player : Player = Players.LocalPlayer

-- Bindables
local BindableFocusLost : BindableEvent = Instance.new("BindableEvent", script) or script:FindFirstChild("FocusLost")
BindableFocusLost.Name = "FocusLost"

-- UI
local PlayerGUI = Player:WaitForChild("PlayerGui")
local ConsoleUI : ScreenGui = PlayerGUI:WaitForChild("C")

local Assets : Folder = ConsoleUI:WaitForChild("Assets")
local AutoCompleteFrames : Frame = ConsoleUI:WaitForChild("Autocomplete")
local ConsoleFrame : Frame = ConsoleUI:WaitForChild("Frame")
local ScrollingFrame : ScrollingFrame = ConsoleFrame:WaitForChild("ScrollingFrame")

local PromptTemplate : Frame = Assets:WaitForChild("Prompt")
local OutputLabel : Frame = Assets:WaitForChild("Label")

-- Modules
local m_ConsoleHandler = require(script:WaitForChild("Handler"))
local m_Scanner = require(script:WaitForChild("Scanner"))
local m_Autocomplete = require(script:WaitForChild("Autocomplete"))

-- Folders
local f_Commands : Folder = script.Parent:WaitForChild("Commands")

-- Initialization
for _, m in pairs({"Terminal v0.1", "This is still under development, so there are certain issues."}) do
    m_ConsoleHandler.Print(m, m_ConsoleHandler.Success)
end

-- Initialize the events

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.Backquote then
        ConsoleFrame.Visible = not ConsoleFrame.Visible
    end
end)

BindableFocusLost.Event:Connect(function()

    local Focused, FocusLost, TextEntered

    Focused = m_ConsoleHandler.CurrentPrompt.Focused:Connect(function()
        AutoCompleteFrames.Visible = true

        local pos = UDim2.new(
            0, m_ConsoleHandler.CurrentPrompt.TextBounds.X + m_ConsoleHandler.CurrentPrompt.AbsolutePosition.X,
            0, m_ConsoleHandler.CurrentPrompt.TextBounds.Y + m_ConsoleHandler.CurrentPrompt.AbsolutePosition.Y)
    
        -- update the autocomplete's position
        AutoCompleteFrames.Position = pos
        m_Autocomplete.setupTokens(nil, m_Autocomplete.AUTOCOMPLETE_TYPE_COMMANDS)
    end)
    
    TextEntered = m_ConsoleHandler.CurrentPrompt:GetPropertyChangedSignal("Text"):Connect(function()
        local pos = UDim2.new(
            0, m_ConsoleHandler.CurrentPrompt.TextBounds.X + m_ConsoleHandler.CurrentPrompt.AbsolutePosition.X,
            0, m_ConsoleHandler.CurrentPrompt.TextBounds.Y + m_ConsoleHandler.CurrentPrompt.AbsolutePosition.Y)
    
        -- update the autocomplete's position
        AutoCompleteFrames.Position = pos

        -- Update autocomplete
        local tokenInfo = m_Scanner.getTokens(m_ConsoleHandler.CurrentPrompt.Text)

        local tokens = tokenInfo.Tokens

        local currentType = m_Autocomplete.AUTOCOMPLETE_TYPE_COMMANDS

        -- Get the autocomplete type
        local req_m = f_Commands:FindFirstChild(tokens[1] or '')

        if req_m then
            req_m = require(req_m)
            currentType = req_m.Params[#tokens - 1]
        end

        --[[ get autcomplete details
        if currentType ~= nil and #tokens ~= 0 then
            AutoCompleteFrames.Visible = true
            m_Autocomplete.setupTokens(tokens[#tokens], currentType)
        else
            AutoCompleteFrames.Visible = false
            m_Autocomplete.setupTokens(nil, currentType)
        end]]

        AutoCompleteFrames.Visible = currentType ~= nil
        local matches = m_Autocomplete.setupTokens(tokens[#tokens], currentType) or {}

        -- Everything except the last token stays the same
        local everything = table.move(tokens, 1, #tokens - 1, 1, {})
        table.insert(everything, matches[#matches])

        m_ConsoleHandler.CurrentPrompt.PlaceHolder.Text = table.concat(everything, " ")
        --m_ConsoleHandler.CurrentPrompt.Text = table.concat(tokens, " ") .. " "
    end)

    FocusLost = m_ConsoleHandler.CurrentPrompt.FocusLost:Connect(function(enterPressed)
        AutoCompleteFrames.Visible = false
        if not enterPressed then return end

        FocusLost:Disconnect()
        Focused:Disconnect()
        TextEntered:Disconnect()
        
        local tokenInfo = m_Scanner.getTokens(m_ConsoleHandler.CurrentPrompt.Text)
        local tokens = tokenInfo.Tokens

        -- Scanning procedure
        local command_token = tokens[1] or ""
        local params = table.move(tokens, 2, #tokens, 1, {})

        local req_m = f_Commands:FindFirstChild(command_token or '')

        if req_m then
            local state, msg = require(req_m).run(params)

            -- If we find a message, print it
            if msg then
                if type(msg) == "table" then
                    for _, v in pairs(msg) do
                        m_ConsoleHandler.Print(v, state)
                    end
                else
                    m_ConsoleHandler.Print(msg, state)
                end
            end
        else
            -- No such command found
            m_ConsoleHandler.Print('"' .. command_token .. '" not found.', m_ConsoleHandler.Error)
        end

        if m_ConsoleHandler.CurrentPrompt and m_ConsoleHandler.CurrentPrompt.Parent then
            m_ConsoleHandler.CurrentPrompt.PlaceHolder.Text = ""
        end

        -- Setup the new prompt
        m_ConsoleHandler.setupPrompt()
        m_ConsoleHandler.CurrentPrompt:CaptureFocus()
        m_ConsoleHandler.CurrentPrompt.Text = ""
    end)
end)

-- Setup a prompt
m_ConsoleHandler.setupPrompt()
