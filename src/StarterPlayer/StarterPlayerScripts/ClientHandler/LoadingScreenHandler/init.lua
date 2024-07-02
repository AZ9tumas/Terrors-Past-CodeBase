local module = {}

module.Loading = false

-- [[ SERVICES ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

-- [[ PLAYER ]]
local Player : Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- [[ SCREEN GUI ]]
local LoadingScreenUI : ScreenGui = PlayerGui:WaitForChild("LoadingScreen")

-- [[ FRAMES ]]
local ProgressFrame : Frame = LoadingScreenUI:WaitForChild("ProgressBar")
local ProgressBar : Frame = ProgressFrame:WaitForChild("Frame")
local load : TextLabel = LoadingScreenUI:WaitForChild("load")

-- [[ REMOTES ]]
local Remotes : Folder = ReplicatedStorage:WaitForChild("Remotes")
local LoadedRemote : RemoteEvent = Remotes:WaitForChild("Loaded")

-- [[ OTHER UI INSTANCES ]]
local Text : TextLabel = LoadingScreenUI:WaitForChild("LoadingText")

-- [[ MODULES ]]
local m_ScreenText = require(script:WaitForChild("LoadingScreenText"))

function module:LoadContents()
    --ContentProvider:PreloadAsync({FSBGFrame})
    ProgressBar.Size = UDim2.new(0, 0, 1, 0)
    LoadingScreenUI.Enabled = true
    Text.Visible = true
    ProgressFrame.Visible = true

    return true
end

local function updateProgressBar(ratio)
    local a = UDim2.new(ratio, 0, 1, 0)
    ProgressBar:TweenSize(a, Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.1)
end

function module:Load(assets, def_text)
    def_text = def_text or m_ScreenText.ScreenText[math.random(1, #m_ScreenText.ScreenText)][1]
    for i, v in pairs(assets) do

        Text.Text = def_text
        ContentProvider:PreloadAsync({v})
        
        load.Text = "Loading " .. v.Name
        updateProgressBar(i / #assets)

    end

    LoadingScreenUI.Enabled = false
    Text.Visible = false
    ProgressFrame.Visible = false
    LoadedRemote:FireServer()
end

--[[

local nextUpdate = tick()

function module:Load(assets, def_text)
    for i, v in pairs(assets) do

        if def_text then
            Text.Text = def_text
        else
            
            if nextUpdate - tick() < 0 then
                local selected = m_ScreenText.ScreenText[math.random(1, #m_ScreenText.ScreenText)]
                nextUpdate = selected[2] + tick()
                Text.Text = selected[1]
            end
        end

        ContentProvider:PreloadAsync({v})
        updateProgressBar(i / #assets)
    end

    LoadingScreenUI.Enabled = false
    FSBGFrame.Visible = false
    Text.Visible = false
    ProgressFrame.Visible = false
end

]]

return module