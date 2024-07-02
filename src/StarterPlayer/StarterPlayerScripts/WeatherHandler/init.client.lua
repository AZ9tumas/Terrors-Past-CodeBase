-- Initialize rain:
local Rain = require(script.Rain)
local Droplets = require(script.Droplets)

Rain:SetColor(Color3.fromRGB(script.Color.Value.x, script.Color.Value.y, script.Color.Value.z))
Rain:SetDirection(script.Direction.Value)

Rain:SetTransparency(script.Transparency.Value)
Rain:SetSpeedRatio(script.SpeedRatio.Value)
Rain:SetIntensityRatio(script.IntensityRatio.Value)
Rain:SetLightInfluence(script.LightInfluence.Value)
Rain:SetLightEmission(script.LightEmission.Value)

Rain:SetVolume(script.Volume.Value)

Rain:SetSoundId(script.SoundId.Value)
Rain:SetStraightTexture(script.StraightTexture.Value)
Rain:SetTopDownTexture(script.TopDownTexture.Value)
Rain:SetSplashTexture(script.SplashTexture.Value)

local threshold = script.TransparencyThreshold.Value
if script.TransparencyConstraint.Value and script.CanCollideConstraint.Value then
	Rain:SetCollisionMode(
		Rain.CollisionMode.Function,
		function(p)
			return p.Transparency <= threshold and p.CanCollide
		end
	)
elseif script.TransparencyConstraint.Value then
	Rain:SetCollisionMode(
		Rain.CollisionMode.Function,
		function(p)
			return p.Transparency <= threshold
		end
	)
elseif script.CanCollideConstraint.Value then
	Rain:SetCollisionMode(
		Rain.CollisionMode.Function,
		function(p)
			return p.CanCollide
		end
	)
end

local rainTweenInfo = TweenInfo.new(10, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

-- Main script
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local params = ReplicatedStorage:WaitForChild("Parameters")
local rainval = params:WaitForChild("Rain")

local isenabled = false

function update()
	if rainval.Value then
		if isenabled then return end
		
		Rain:Enable(rainTweenInfo)
		Droplets:Enable()
		isenabled = true
	else
		if not isenabled then return end
		Rain:Disable(rainTweenInfo)
		Droplets:Disable()
		isenabled = false
	end
end

rainval.Changed:Connect(update)

while wait(10) do
	update()
end