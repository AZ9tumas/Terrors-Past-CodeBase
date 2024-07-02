-- Client.Bite

local bite = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Folders
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

-- Events
local thisCombatEvent : RemoteEvent = Remotes:WaitForChild("Bite")
local PrimaryAttack : BindableFunction = script.Parent:WaitForChild("PrimaryAttackBindable")

-- Player Instances
local Player : Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local HudGui : ScreenGui = PlayerGui:WaitForChild("HUD")
local HudFrame : Frame = HudGui:WaitForChild("HUD")
local Damagelabel : Frame = HudFrame:WaitForChild("Damagelabel")

-- Character Instances
local Character : Model = Player.Character
local HitBox : BasePart = Character:WaitForChild("Hitbox")
local Head = Character:WaitForChild("Head")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Raycast params
local rayCastParams = RaycastParams.new()
rayCastParams.IgnoreWater = false
rayCastParams.FilterType = Enum.RaycastFilterType.Exclude
rayCastParams.FilterDescendantsInstances = Character:GetDescendants()

bite.Invoke = function()
    -- Invoke this combat technique / ability.
    thisCombatEvent:FireServer()
    PrimaryAttack:Invoke("Attack")
end

coroutine.wrap(function()
    while task.wait() do
        local dir = HumanoidRootPart.CFrame.LookVector * 2.5
        local bc = workspace:Blockcast(HitBox.CFrame, HitBox.Size, dir, rayCastParams)

        if bc and bc.Instance and bc.Instance.Parent and bc.Instance.Parent:FindFirstChild("Humanoid") then
            Damagelabel.Visible = true
        else
            Damagelabel.Visible = false
        end
    end
end)()

return bite