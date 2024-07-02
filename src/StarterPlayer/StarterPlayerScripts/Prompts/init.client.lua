local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")

local Player = Players.LocalPlayer

-- Everytime we see that the character has changed,
-- We have to update prompts

-- Modules
local m_Prompt = require(script:WaitForChild("Prompt"))

Player.CharacterAdded:Connect(function()
    -- If the player menu'd, then you wait till they spawn in again.
    repeat wait(1) until Player:GetAttribute("Type")

    local dinoType = Player:GetAttribute("Type")

    -- Change prompt colors
    m_Prompt.SetLabels(dinoType)

    -- Time to reset the prompts
    m_Prompt.MakePrompts(dinoType)
end)

Player.CharacterRemoving:Connect(function()
    -- Delete the parts when the player dies.
    m_Prompt.DeleteParts()
end)

ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
    m_Prompt.Tween(nil, 1, prompt.HoldDuration)
end)

ProximityPromptService.PromptButtonHoldEnded:Connect(function()
    m_Prompt.Tween(nil, 0)
end)

-- Hide / Show the prompts
ProximityPromptService.PromptShown:Connect(function() m_Prompt.SetVisibility(true) end)
ProximityPromptService.PromptHidden:Connect(function() m_Prompt.SetVisibility(false) end)