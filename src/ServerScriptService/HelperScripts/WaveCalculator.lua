--[[
Credits:

robro786 (Chicken)

5/18/2021

--> slightly edited by az9

]]

--[[
NOTE: 

Waves use their own clock to calculate wave height. Since that clock is private and invisible from the lua
side, a separate clock needs to be kept in this script to emulate the waves. If these clocks are desynced, the waves
will appear desynced. This means that both clocks must start at the same time, so THIS SCRIPT SHOULD BE
REQUIRED IMMEDIATELY

I recommend initially setting your wavespeed to 0 in studio, then, in a LocalScript, require this module
and then set your wavespeed to the desired values. That way, both clocks start at 0.
]]

local module = {}

local runService = game:GetService("RunService")
local terrain = game.Workspace:WaitForChild("Terrain")

-- these are roblox-set values, they aren't meant to be changed
local MAX_WAVE_MAGNITUDE = 1.94 -- studs (Terrain.WaterWaveSize is NOT measured in studs like the documentation says)
local MAX_WAVELENGTH = 85 -- studs

local wavesize = workspace.Terrain.WaterWaveSize
local wavespeed = workspace.Terrain.WaterWaveSpeed



local function getWavelength()
	local a = math.sqrt(terrain.WaterWaveSize)
	return a * MAX_WAVELENGTH
end

workspace.Terrain.WaterWaveSize = 0
workspace.Terrain.WaterWaveSpeed = 0
wait(0.2)
workspace.Terrain.WaterWaveSize = wavesize
workspace.Terrain.WaterWaveSpeed = wavespeed

--print("Reset the waves on the water")

-- approximation, catch up in case this script was required a few seconds late
local wt = time() * terrain.WaterWaveSpeed  -- ideally, time() will be about 0 when this runs
runService.Stepped:Connect(function(t, dt)
	wt += dt * terrain.WaterWaveSpeed 
	script.Clock.Value = wt
end)


function module:calcWaterHeightOffset(x, z)
	if terrain.WaterWaveSize > .02 then -- don't divide by 0
		local w = getWavelength()
		local o = math.cos(2 * math.pi * (x + wt) / w) * math.sin(2 * z * math.pi / w)
		o *= terrain.WaterWaveSize * MAX_WAVE_MAGNITUDE
		return o
	else
		return 0
	end
end

do -- make sure the clock starts before this module returns
	local c = true
	c = runService.Stepped:Connect(function()
		c:Disconnect()
		c = nil
	end)

	repeat wait() until not c
end

return module