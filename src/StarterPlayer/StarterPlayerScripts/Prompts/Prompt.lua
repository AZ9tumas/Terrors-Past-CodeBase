local prompt = {}

-- Services
local TweenService = game:GetService("TweenService")

-- Player and Player UI
local Player = game.Players.LocalPlayer
local PlayerUI = Player:WaitForChild("PlayerGui")
local PromptFrame : Frame = PlayerUI:WaitForChild("HUD"):WaitForChild("HUD"):WaitForChild("PressE")
local Frame : Frame = PromptFrame:WaitForChild("Frame")

-- Keeping track of all the parts
prompt.Parts = {}

-- Other params
prompt.Hold = false
prompt.Visible = false
prompt.CurrentTween = nil

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local m_PromptManager = require( ReplicatedStorage:WaitForChild("PromptManager") )

function prompt.MakePrompts(folderName : string, n : number)
    -- Get the required prompts
    local parts = workspace:FindFirstChild(folderName) or {}

    if folderName == "Omnivores" then
        -- Omnivores = Herbivores + Carnivores
        for _, v in pairs(workspace["Carnivores"]:GetChildren()) do
            table.insert(parts, v)
        end

        for _, j in pairs(workspace["Herbivores"]:GetChildren()) do
            table.insert(parts, j)
        end
    end

    if not parts then return warn("No food parts found for", folderName) end
    
    -- Set the parts
    prompt.Parts = type(parts) == "table" and parts or parts:GetChildren()

    -- Get the parts, and make new prompts
    for _, part : Part in pairs(prompt.Parts) do
        -- Create the prompt
        m_PromptManager.CreatePrompt(part:IsA("Model") and part.PrimaryPart or part)
        
    end
end

function prompt.DeleteParts()
    -- Return if we don't find the required parts
    if not prompt.Parts then return end

    -- Clear the prompts under each and every single food part
    for _, v : Part in pairs(prompt.Parts) do
        v:ClearAllChildren()
    end
end

-- Prompt labels

function prompt.SetLabels(dinosaurType)
    if dinosaurType == "Carnivores" then
        PromptFrame.BackgroundColor3 = Color3.new(0.568627, 0.003921, 0.003921)
        Frame.BackgroundColor3 = Color3.new(1, 0, 0)
    elseif dinosaurType == "Herbivores" then
        PromptFrame.BackgroundColor3 = Color3.new(0.207843, 0.533333, 0.003921)
        Frame.BackgroundColor3 = Color3.new(0.333333, 1, 0)
    else
        PromptFrame.BackgroundColor3 = Color3.fromRGB(154, 154, 77)
        Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 127)
    end
end

function prompt.Tween(inst : Frame, x, time)
    time = time or 0.2
    inst = inst or Frame
    
    if prompt.CurrentTween then prompt.CurrentTween:Cancel() end
    
    prompt.CurrentTween = TweenService:Create(inst, TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = UDim2.new(x, 0, 1, 0)})
    prompt.CurrentTween:Play()
end

function prompt.SetVisibility(value)
    -- Tween back to initial position
    prompt.Tween(Frame, 0)
    -- Show / Hide the prompt
    PromptFrame.Visible = value
    prompt.Visible = value
end

return prompt