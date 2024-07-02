local module = {}

-- [[ SERVICES ]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')

-- [[ REMOTES ]]
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local RoarRemote : RemoteEvent = Remotes:WaitForChild("Roar")
local EatorDrinkRemote : RemoteEvent = Remotes:WaitForChild("EatorDrink")
local MechanicRemote = Remotes:WaitForChild("Mechanic")

-- [[ PLAYER PARAMS ]]
local Player = game.Players.LocalPlayer
local Character = script.Parent.Parent.Parent
local Humanoid : Humanoid = Character:WaitForChild('Humanoid')
-- Disable default roblox swimming
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)

-- [[ OTHER MODULES ]]
local PlayerScripts = Player:WaitForChild("PlayerScripts")
local PlayerModule = require(PlayerScripts.PlayerModule)
local Controls = PlayerModule:GetControls()
local CameraModule = require(script.Parent.FovHandler)
local AnimationHandler = require(script.Parent.Parent.Animations)

-- [[ BINDABLES ]]
local PrimaryAttackBindable : BindableFunction = script.Parent.Parent:WaitForChild("PrimaryAttackBindable")

-- [[ LOCAL VARIABLES ]]
local States = { [0] = "Walk", "Crouch Walk", "Run", "Dash" }

-- Some of the keys are manually defined under the userinputbegan signal handler
module.SpecialKeys = { Enum.KeyCode.C, Enum.KeyCode.LeftShift }
module.Linker = { Enum.KeyCode.C, Enum.KeyCode.LeftShift, Enum.KeyCode.X }

module.Keys = {}

function module.Controls(val)
	if val then Controls:Enable() else Controls:Disable() end
end

function module.init()
	-- Initialize
	module.Debounce = true
	module.SideDebounce = true
	module.CurrentState = "Idle"
	module.Index = 0
	module.isResting = false
	
	-- Load animations
	AnimationHandler:LoadAnimations()
	
	-- Start playing and handling the current states
	module.HandleMechanic()
end

function module.UpdateIndex()
	module.Index = 0

	for indx : number, keycode : Enum.KeyCode in pairs(module.Linker) do
		if table.find(module.Keys, keycode) then
			module.Index = indx
		end
	end
end

function module.GetCurrentAnimationState()
	-- Some exceptional cases:
	if Player.Swimming.Value then module.CurrentState = "Swim" return end
	if module.isResting then module.CurrentState = "Rest" return end
	if Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid.Jump then module.CurrentState = "Freefall" return end
	
	module.UpdateIndex()

	local state = "Idle"

	if Humanoid.MoveDirection.Magnitude > 0 then
		state = States[module.Index]
	elseif module.Index == 1 then
		state = "Crouch Idle"
	end

	if state == "Run" then
		-- sprint
		Humanoid.WalkSpeed = Player:GetAttribute("RunSpeed")
	elseif state == "Dash" then
		Humanoid.WalkSpeed = Player:GetAttribute("DashSpeed")
	elseif state == "Walk" then
		Humanoid.WalkSpeed = Player:GetAttribute("Speed")
	elseif state == "Crouch Walk" or state == "Crouch Idle" then
		Humanoid.WalkSpeed = Player:GetAttribute("CrouchSpeed")
	end

	module.CurrentState = state
end

function module.HandleMechanic()
	if not module.Debounce then return end
	module.Debounce = false
	
	module.GetCurrentAnimationState()
	CameraModule:SetFOV(module.Index)
	
	AnimationHandler:PlayAnimation(module.CurrentState)
	
	MechanicRemote:FireServer(module.Index)
	module.Debounce = true
end

-- [[ OTHER TYPES OF MECHANICS ]]

function module.Rest(rest)
	if Player.Swimming.Value then return end
	if not module.Debounce then return end
	module.Debounce = false

	module.Keys = {}
	
	if rest then module.Controls(false) end
	module.isResting = rest
	
	local stats, length = AnimationHandler:PlayAnimation(rest and "SitDown" or "GetUp")
	if stats then task.wait(length + 0.025) end
	
	if not rest then module.Controls(true) end
	
	module.Debounce = true
	module.HandleMechanic()
end

function module.Roar(RoarType : string)
	if not module.SideDebounce then return end
	module.SideDebounce = false
	
	local _, length = AnimationHandler:PlayRawAnimation(RoarType)
	if RoarType == "Threat" then RoarType = "Threaten" end
	
	RoarRemote:FireServer(RoarType)
	
	task.wait(length + 0.025)
	module.SideDebounce = true
end

function module.Eat(Prompt : ProximityPrompt)
	if module.isResting then return end
	if not module.Debounce then return end
	module.Debounce = false
	
	module.Controls(false)
	
	Humanoid:MoveTo(Prompt.Parent.Position)
	module.HandleMechanic()
	Humanoid.MoveToFinished:Wait()
	
	local _, length = AnimationHandler:PlayAnimation("Eat")
	EatorDrinkRemote:FireServer("Eat", Prompt.Parent)
	
	task.wait(length + 0.025)
	
	module.Controls(true)
	
	EatorDrinkRemote:FireServer(nil, nil)
	module.Debounce = true
	module.HandleMechanic()
end

PrimaryAttackBindable.OnInvoke = function(...)
	local animationToPlay : string = ({...})[1]

	--module.Controls(false)

	local _, length = AnimationHandler:PlayRawAnimation(animationToPlay)
	task.wait(length)

	--module.Controls(true)
	module.HandleMechanic()
end

-- Reset mechanics
local ClientEvent = Player.Stamina:GetPropertyChangedSignal("Value"):Connect(function()
	if Player.Stamina.Value <= 0 then
		module.Keys = {}
		module.HandleMechanic()
	end
end)

local SwimRBXConnection = Player.Swimming.Changed:Connect(function()
	module.HandleMechanic()
end)

function module.Clean()
	ClientEvent:Disconnect()
	SwimRBXConnection:Disconnect()

	module.Keys = {}
	module.HandleMechanic()
	module.Controls(true)
end

return module
