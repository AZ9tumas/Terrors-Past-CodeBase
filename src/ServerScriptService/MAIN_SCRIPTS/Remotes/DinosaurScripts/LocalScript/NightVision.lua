local module = {}

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local NightVisionRemote = Remotes:WaitForChild("NightVision")

module.Debounce = true
module.NightVision = false

local stuffbefore = {
	game.Lighting:GetAttribute("OutdoorAmbient"), 
	game.Lighting:GetAttribute("ColorCorrection"),
	game.Lighting:GetAttribute("Density"), 
	game.Lighting:GetAttribute("Saturation")
}

function module:Toggle(val)
	if not module.Debounce then return end
	module.Debounce = false
	
	module.NightVision = val
	NightVisionRemote:FireServer(val)
	
	if val then
		game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
		game.Lighting.ColorCorrection.Enabled = true
		game.Lighting.Atmosphere.Density = 0.64
		game.Lighting.ColorCorrection.Saturation = -1
	else
		game.Lighting.OutdoorAmbient = stuffbefore[1]
		game.Lighting.ColorCorrection.Enabled = stuffbefore[2]
		game.Lighting.Atmosphere.Density = stuffbefore[3]
		game.Lighting.ColorCorrection.Saturation = stuffbefore[4]
	end
	
	module.Debounce = true
end

return module
