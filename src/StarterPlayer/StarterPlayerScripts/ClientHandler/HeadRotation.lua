local module = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Remotes
local Remotes : Folder = ReplicatedStorage:WaitForChild("Remotes")
local UpdateLookVectorEvent : RemoteEvent = Remotes:WaitForChild("LookVector")

-- Instances
local CurrentCamera : Camera = workspace.CurrentCamera
local Player : Player = game.Players.LocalPlayer

-- Globals
module.DELTA_CAMERA_SHIFT = 3
module.DELTA_TIME = 0.1

module.Params = {
    LastSnapShot = tick(),
    LastCFrame = CurrentCamera.CFrame
}

function module.UpdateStatus()
    -- Send camera details to the server

    -- Has the player morphed yet?
    if not Player:GetAttribute("Loaded") then return end

    -- Time debounce
    if tick() - module.Params.LastSnapShot < module.DELTA_TIME then return end

    -- Register only large movements made on the camera
    if (module.Params.LastCFrame.Position - CurrentCamera.CFrame.Position).Magnitude < module.DELTA_CAMERA_SHIFT then return end


    module.Params.LastSnapShot = tick()
    module.Params.LastCFrame = CurrentCamera.CFrame

    coroutine.wrap(function()
        UpdateLookVectorEvent:FireServer(CurrentCamera.CFrame)
    end)()
end

return module