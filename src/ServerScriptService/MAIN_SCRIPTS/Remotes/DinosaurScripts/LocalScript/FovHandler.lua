local module = {}

local TweenService = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

local Camera = workspace.CurrentCamera
Camera.CameraType = Enum.CameraType.Follow

local CurrentFOV = 70 -- Camera.FieldOfView
module.FOV_Details = {
	[0] = CurrentFOV, -- Default FOV
	CurrentFOV - 10, -- Crouch FOV
	CurrentFOV + 10, -- Sprint FOV
	CurrentFOV + 20, -- Dash FOV
}

local function TweenFOV(fov)
	local tween = TweenService:Create(Camera, tweeninfo, {FieldOfView = fov})
	tween:Play()
end

function module:SetFOV(pos)
	TweenFOV(module.FOV_Details[pos])
end

return module
