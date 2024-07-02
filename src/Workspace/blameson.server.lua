local anim : Animation = script:WaitForChild("Animation")
local blame = workspace:WaitForChild("SirBlameson")
local humanoid : Humanoid = blame:WaitForChild("Humanoid")

local track = humanoid:LoadAnimation(anim)

track:Play()
track.Looped = true

print(track)