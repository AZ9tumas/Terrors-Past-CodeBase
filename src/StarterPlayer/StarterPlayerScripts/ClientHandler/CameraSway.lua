local module = {}

--Services
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

--constants
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local InitialSwaySpeedX, InitialSwaySpeedY = .015, .005 -- IDLE sway speed
local MaxSwayY = 0.0005 --center position
local IdleLerpSpeed = .01

--[[
    These lines are creating local variables that store various constants used in the script. PLAYER refers to the local player in the game, CAMERA refers to the current camera 
    in the game, SX and SY store the idle sway speed for the camera in the X and Y directions respectively, MXY stores the center position of the camera sway, SIN is a reference 
    to the math.sin function, PI_2 is a constant representing 2 times pi, and IDLE_LERP_SPEED stores a value that determines how fast the camera's idle sway lerps or transitions 
    between values.
]]

--varibables 
local swayAngle_X, swayAngle_Y = 0, 0  -- keep track of the camera's X and Y sway angles
local swaySpeed_X, swaySpeed_Y = InitialSwaySpeedX, InitialSwaySpeedY -- keep track of the current sway speed in the X and Y directions
local swayCenterX, swayCenterY = MaxSwayY, MaxSwayY -- keep track of the current center position of the camera sway

--[[
    These lines are creating local variables that store various initial values for the camera sway. ix and iy are used to keep track of the camera's X and Y sway angles, 
    respectively. lsx and lsy are used to keep track of the current sway speed in the X and Y directions, respectively, which start with the values of SX and SY as the initial 
    sway speeds. lx and ly are used to keep track of the current center position of the camera sway, which start with the values of MXY as the initial center positions.
]]

--variables
local turn = 0

local hrp_turn = 0

local lerp = function(a, b, t) return a + (b - a) * t end

function module:CameraSway(val)
    Player.CameraMode = Enum.CameraMode[val and "LockFirstPerson" or "Classic"]
end

--[[
    PLAYER.CameraMode = Enum.CameraMode.LockFirstPerson: This sets the camera mode of 
    the local player to "LockFirstPerson", which means the camera will be locked in first-person view.
]]

function module:Run(deltaTime)
    if deltaTime > 0.5 then return end -- If we lag, then no camera shake effects

    local MouseDelta = UserInputService:GetMouseDelta()
	turn = lerp(turn, math.clamp(MouseDelta.X, -3, 3), 15 * deltaTime)

	swayAngle_X = (swayAngle_X + swaySpeed_X) % (math.pi * 2)
	swayAngle_Y = (swayAngle_Y + swaySpeed_Y) % (math.pi * 2)

    local MouseTurnCFrame = CFrame.Angles(0, 0, math.rad(turn))
    local IdleSwayCFrame = CFrame.Angles(math.sin(swayAngle_X) * swayCenterX, math.sin(swayAngle_Y) * swayCenterY, 0)

    local hrpTurnCFrame = CFrame.Angles(0, 0, 0)
    
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        hrp_turn = lerp(hrp_turn, math.clamp(35 * Player.Character.Humanoid.MoveDirection.X, -6, 6), 5 * deltaTime)
        hrpTurnCFrame = CFrame.Angles(0, 0, math.rad(hrp_turn))
    end
    
	Camera.CFrame = Camera.CFrame * MouseTurnCFrame * IdleSwayCFrame
end

return module