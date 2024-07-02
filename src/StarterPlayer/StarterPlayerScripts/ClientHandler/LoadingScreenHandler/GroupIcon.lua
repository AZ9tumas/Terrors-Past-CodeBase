--[[Configuration]]--

local warperFramerate = 24 -- Do i need to explain this? (Caps at 60 cuz roblox bad) (additionally, this does not support frame skipping)
local lastFrame = 1 -- Frame the animation starts at
local frames = 5*5 -- Amount of frames in the animation
local rows = 5 -- Amount of vertical frames in the animation
local columns = 5 -- Amount of horizontal frames in the animation

local AnimationFrameWrapper = script.Parent.Warper -- The parent frame to the animated sprite, has clipping enabled so that only one frame can be displayed at once

local AnimatedSprite = AnimationFrameWrapper.Animated -- The image you're animating

local t = tick() -- Used in animation framerate timing

AnimatedSprite.Size = UDim2.new(columns,0,rows,0) -- Sets the size of the image in case you set it wrong, really easy tho

local function AnimationFunction()
	-- Extra animation function that was used in the loading screen, can be used to execute special code during an animation
	--(eg u were lazy and decided to change the transparency via the animation instead of doing it in the sprite)
end

local function UpdateWarper(f)
	if tick()-t >= 1/warperFramerate then -- check if enough time has passed between frames to update the sprite
		lastFrame = lastFrame + 1
		if lastFrame > frames then lastFrame = 1 end -- Loop gif
		local CurrentColumn = lastFrame -- set the current horizontal frame to the current frame
		local CurrentRow = 1
		repeat -- This gets what the current column and row should be based on the current frame (this is why we set CurrentColumn to lastFrame earlier)
			if CurrentColumn>columns then
				CurrentColumn = CurrentColumn - columns
				CurrentRow = CurrentRow + 1
			end
		until not(CurrentColumn>columns)
		
		-- Update the image label
		AnimationFrameWrapper.Animated.Position = UDim2.new(-(CurrentColumn-1),0,-(CurrentRow-1),0)
		f() -- This was used originally to 
		
		t = tick()
	end
end

game:GetService("RunService").RenderStepped:Connect(function()
	UpdateWarper(AnimationFunction)
end)
-- you can tie this into any existing runservice you might already have