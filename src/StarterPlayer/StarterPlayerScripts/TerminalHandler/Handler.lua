local module = {}

-- Services
local Players = game:GetService("Players")

-- Player
local Player : Player = Players.LocalPlayer

-- Bindables
local bindable : BindableEvent = script.Parent:WaitForChild("FocusLost")

-- UI
local PlayerGUI = Player:WaitForChild("PlayerGui")
local ConsoleUI : ScreenGui = PlayerGUI:WaitForChild("C")

local Assets : Folder = ConsoleUI:WaitForChild("Assets")
local ConsoleFrame : Frame = ConsoleUI:WaitForChild("Frame")
local ScrollingFrame : ScrollingFrame = ConsoleFrame:WaitForChild("ScrollingFrame")

local PromptTemplate : Frame = Assets:WaitForChild("Prompt")
local OutputTemplate : Frame = Assets:WaitForChild("Label")

-- States
module.Error = 0
module.Success = 1
module.Warning = 2

-- Public globals
module.CurrentPrompt = nil

function module.Print(message : string, status : number)
    local reqColor = {
        [0] =Color3.new(0.647058, 0.019607, 0.019607),
        Color3.new(1, 1, 1),
        Color3.new(0.780392, 0.780392, 0.031372)
    }

    reqColor = reqColor[status]

    local output : TextLabel = OutputTemplate:Clone()
    output.Text = message
    output.TextColor3 = reqColor

    output.Visible = true

    output.Parent = ScrollingFrame

    return output
end

function module.setupPrompt() : Frame
    local newprompt = PromptTemplate:Clone()
    newprompt.Parent = ScrollingFrame
    newprompt.Visible = true
    module.CurrentPrompt = newprompt.TextBox

    bindable:Fire()

    return newprompt
end

return module