-- [[ SERVICES ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGuiService = game:GetService("StarterGui")

-- [[ MODULES ]]
local m_UserInterfaceHandler = require(script:WaitForChild("Handler"))
local m_UtilityModule = require(ReplicatedStorage:WaitForChild("DinosaurStatsUtilityModule"))
local m_CameraSwayModule = require(script:WaitForChild("CameraSway"))
local m_HeadTurning = require(script:WaitForChild("HeadRotation"))
local m_LoadingScreenHandler = require(script:WaitForChild("LoadingScreenHandler"))
local m_SoundHandler = require(script:WaitForChild("SoundHandler"))
local m_Button = require(script.Handler:WaitForChild("Button"))

-- [[ PLAYER PARAMS ]]
local Player : Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local PlayerScripts = Player:WaitForChild("PlayerScripts")

local PlayerModule = require(PlayerScripts.PlayerModule)
local Mouse : Mouse = Player:GetMouse()
local Camera : Camera = workspace.CurrentCamera

-- [[ REMOTES ]]
local Remotes : Folder = ReplicatedStorage:WaitForChild("Remotes")
local ClientSelection : RemoteEvent = Remotes:WaitForChild("ClientSelection")
local MorphFunction : RemoteFunction = Remotes:WaitForChild("ChangeDino")
local LoadAnimationsRemote : RemoteFunction = Remotes:WaitForChild("LoadAnimations")
local RedeemRemote : RemoteEvent = Remotes:WaitForChild("Redeem")
local RedoLocks : RemoteEvent = Remotes:WaitForChild("RedoLocks")
local MenuResetRemote : RemoteEvent = Remotes:WaitForChild("MenuReset")
local Buy : RemoteFunction = Remotes:WaitForChild("Buy")
local SettingsRemote : RemoteEvent = Remotes:WaitForChild("Settings")

-- [[ SCREEN GUI ]]
local MenuUI = PlayerGui:WaitForChild("MenuUI")
local HUD : ScreenGui = PlayerGui:WaitForChild("HUD")
local Volume : ScreenGui = PlayerGui:WaitForChild("Volume")

-- [[ FRAMES ]]
local MainScreenFrame : Frame = MenuUI:WaitForChild("MainScreen")
local SelectDinosaurFrame : Frame = MenuUI:WaitForChild("SelectDinosaur")
local DinoSelectionbase : Frame = MenuUI:WaitForChild("DinoSelectionBase")
local BooketFrame : Frame = MenuUI:WaitForChild("BookletBase")
local RedeemFrame = MenuUI:WaitForChild("Redeem")
local SettingsFrame : Frame = MenuUI:WaitForChild("Settings")

local HUDFrame : Frame = HUD:WaitForChild("HUD")
local HUDBase : ImageLabel = HUDFrame:WaitForChild("Base")
local HealthFrame : ImageLabel = HUDBase:WaitForChild("HealthFrame"):WaitForChild("Health")
local HungerFrame : ImageLabel = HUDBase:WaitForChild("HungerFrame"):WaitForChild("Hunger")
local StaminaFrame : ImageLabel = HUDBase:WaitForChild("StaminaFrame"):WaitForChild("Stamina")
local ThirstFrame : ImageLabel = HUDBase:WaitForChild("ThirstFrame"):WaitForChild("Thirst")
local MenuResetFrame : ImageLabel = HUDFrame:WaitForChild("AreYouSure")
local ProgressFrame : Frame = MenuUI:WaitForChild("ProgressScreen")
local FailedUnlockFrame : Frame = MenuUI:WaitForChild("FailedUnlock")
local SuccessfullUnlockFrame : Frame = MenuUI:WaitForChild("Unlocked")
local DamageScreen1 : Frame = MenuUI:WaitForChild("DamageScreen1")
local DamageScreen2 : Frame = MenuUI:WaitForChild("DamageScreen2")
local DamageScreen3 : Frame = MenuUI:WaitForChild("DamageScreen3")

-- [[ BUTTONS ]]
local Back = m_Button.new(MenuUI:WaitForChild("Back"))
local SelectButton = m_Button.new(BooketFrame:WaitForChild("Select"))
local PlayButton = m_Button.new(MainScreenFrame:WaitForChild("Play"))
local IButton = m_Button.new(DinoSelectionbase:WaitForChild("I"))
local RedeemButton = m_Button.new(RedeemFrame:WaitForChild("Redeem"))
local CurrentSelection = m_Button.new(MainScreenFrame:WaitForChild("CurrentSelection"))
-- HUD buttons
local MenuButton = m_Button.new(HUDFrame:WaitForChild("Menu"))
local MenuYesButton = m_Button.new(MenuResetFrame:WaitForChild("Yes"))
local MenuNoButton = m_Button.new(MenuResetFrame:WaitForChild("No"))
-- Volume button
local VolumeButton = m_Button.new(Volume:WaitForChild("VolumeButton"))
-- Progress frame buttons
local ProgressYes = m_Button.new(ProgressFrame:WaitForChild("Yes"))

-- [[ OTHER STUFF ]]
local RedeemTextBox : TextBox = RedeemFrame:WaitForChild("RedeemBox")
local HoverLabel : TextLabel = MenuUI:WaitForChild("dino")
local FailedUnlockLabel : TextLabel = FailedUnlockFrame:WaitForChild("Sorry"):WaitForChild("Nerd")
local SuccessfullUnlockLabel : TextLabel = SuccessfullUnlockFrame:WaitForChild("Winner"):WaitForChild("Dinosaur")
local GrowthBar : TextLabel = HUDFrame:WaitForChild("Growth")

local Stamina : NumberValue = Player:WaitForChild("Stamina")
local Hunger : NumberValue = Player:WaitForChild("Hunger")

local SoundOff = "rbxassetid://13982183205"
local SoundOn = "rbxassetid://13982182818"

-- init
StarterGuiService:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
m_SoundHandler:Play("MenuSong")
m_UserInterfaceHandler:HandleBackButton()
m_LoadingScreenHandler:LoadContents()
m_SoundHandler:LoadSounds()
m_LoadingScreenHandler:Load(MenuUI:GetDescendants())

-- helper functions

local function report_failure(text)
	FailedUnlockLabel.Text = text
	m_SoundHandler:Play("Fail")
	
	m_UserInterfaceHandler.Debounce = true
	
	return m_UserInterfaceHandler:ShowFrame(FailedUnlockFrame)
end

local function handle_menu_sound(val)
	if val then
		m_SoundHandler:Play("MenuSong")
		VolumeButton.Image = SoundOn
	else
		m_SoundHandler:Pause("MenuSong")
		VolumeButton.Image = SoundOff
	end
end

local function Controls(val)
	local controls = PlayerModule:GetControls()
	controls:Enable(val)
end

--[[ Initialize the buttons on the main menu: ]]

-- Initialize the params in the settings menu
for _, v in pairs(SettingsFrame:GetChildren()) do
	if not v:IsA("ImageButton") then continue end

	-- Init the button
	local s_button = m_Button.new(v)
	
	s_button:Click(function()

		SettingsRemote:FireServer(v.Name, v.Play.Text ~= "Enabled")
		v.Play.Text = v.Play.Text == "Enabled" and "Disabled" or "Enabled"
	end)

	-- Change the param to the respective value
	v.Play.Text = Player:GetAttribute("Settings" .. v.Name) and "Enabled" or "Disabled"
end

for key, val in pairs(Player:GetAttributes()) do
	if string.find(key, "Settings") then
		print(key, val)
	end
end

for _, button in pairs( { "Settings", "SelectDinosaur", "Redeem", "Credits" } ) do
	local requiredButton = MainScreenFrame[button]
	local requiredFrame = MenuUI[requiredButton.Name]
	local newButton = m_Button.new(requiredButton)

	newButton:Click(function()
		if not m_UserInterfaceHandler.Debounce then return end
		m_UserInterfaceHandler:ShowFrame(requiredFrame, false)
	end)

	newButton:HoverStart(function()end)
end

for _, button in pairs(SelectDinosaurFrame:GetChildren()) do
	if not button:IsA("ImageButton") then continue end
	if not MenuUI:FindFirstChild(button.Name) then continue end
	local newButton = m_Button.new(button)

	newButton:Click(function()
		if not m_UserInterfaceHandler.Debounce then return end
		m_UserInterfaceHandler:ShowFrame(MenuUI[button.Name])
	end)

	newButton:HoverStart(function()end)
end

-- [[ ALL EVENTS LINKED TO SPECIFIC BUTTONS ]]

IButton:Click(function()
	if not m_UserInterfaceHandler.Debounce then return end

	m_UserInterfaceHandler:ShowFrame(MenuUI:WaitForChild("BookletBase"))
end)

Back:Click(function()
	if not m_UserInterfaceHandler.Debounce then return end
	m_UserInterfaceHandler:HandleBackButton()

	local LastVisitedFrame = m_UserInterfaceHandler.FramesVisited[#m_UserInterfaceHandler.FramesVisited]
	if not LastVisitedFrame then return warn("Can't go back from here.") end

	m_UserInterfaceHandler:ShowFrame(LastVisitedFrame, true)
end)

CurrentSelection:Click(function()
	if not m_UserInterfaceHandler.Debounce then return end

	m_UserInterfaceHandler.CurrentSelection = nil
	m_UserInterfaceHandler.ImageId = nil
	CurrentSelection.Visible = false
end)

RedeemButton:Click(function()
	RedeemRemote:FireServer(RedeemTextBox.Text)
end)

SelectButton:Click(function()
	if not m_UserInterfaceHandler.Debounce then return end

	local selected = m_UserInterfaceHandler.Pressed

	m_UserInterfaceHandler:SelectDinosaur(selected)
	m_UserInterfaceHandler:ShowFrame(MainScreenFrame)
	m_UserInterfaceHandler:ResetFrameRoad()
end)

PlayButton:Click(function()
	if not m_UserInterfaceHandler.Debounce then return end
	if not m_UserInterfaceHandler.CurrentSelection then return end
	m_UserInterfaceHandler.Debounce = false

	local success, err = false, "Unable to morph into that dinosaur."

	pcall(function()
		success, err = MorphFunction:InvokeServer(
			m_UserInterfaceHandler.CurrentSelection,
			m_UtilityModule.getDinosaurType(m_UserInterfaceHandler.CurrentSelection)
		)
	end)

	if not success then
		-- show the failed purchase screen
		return report_failure(err)
	end

	Controls(false)

	task.wait(m_UserInterfaceHandler:FadeBlackScreen(0.25, true))

	m_UserInterfaceHandler:HideAllFrames()
	m_LoadingScreenHandler:LoadContents()

	-- Manually load in animations once again
	local AnimationsFolder : Folder = LoadAnimationsRemote:InvokeServer()
	if not AnimationsFolder then return report_failure("There was an issue in fetching the assets of this dinosaur.") end

	local parts = {}
	for _, v in pairs(Player.Character:GetDescendants()) do

		if v:IsA("Part") or v:IsA("BasePart") or v:IsA("MeshPart")
			 then table.insert(parts, v) end
	end

	m_LoadingScreenHandler:Load(parts, "Loading " .. m_UserInterfaceHandler.CurrentSelection)
	-- unloading of loadingScreen happens, and the curtains are removed.

	m_SoundHandler:Stop("MenuSong")

	Camera.CameraType = Enum.CameraType.Follow
	coroutine.wrap(function()

		local Humanoid : Humanoid = Player.Character:WaitForChild("Humanoid")
		local HumanoidRootPart : BasePart = Player.Character:WaitForChild("HumanoidRootPart")

		Camera.CameraSubject = HumanoidRootPart

		Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			if Humanoid.Health < 0.1 * Humanoid.MaxHealth then
				-- Extensive
				DamageScreen1.Visible = true
				DamageScreen2.Visible = true
				DamageScreen3.Visible = true

			elseif Humanoid.Health < 0.35 * Humanoid.MaxHealth then
				-- Mid

				DamageScreen1.Visible = true
				DamageScreen2.Visible = true

			elseif Humanoid.Health < 0.65 * Humanoid.MaxHealth then
				-- Less
				DamageScreen1.Visible = true
			
			else
				-- Reset
				DamageScreen1.Visible = false
				DamageScreen2.Visible = false
				DamageScreen3.Visible = false
			end
		end)
	end)()

	Controls(true)

	task.wait(m_UserInterfaceHandler:FadeBlackScreen(0.25, false))

	MenuUI.Parent.HUD.Enabled = true
	MenuUI.Parent.HUD.HUD.Visible = true
	m_UserInterfaceHandler.Debounce = true
end)

MenuButton:Click(function()
	if not m_UserInterfaceHandler.Debounce then return end
	MenuResetFrame.Visible = true
end)

MenuYesButton:Click(function()
	if not m_UserInterfaceHandler.Debounce then return end
	MenuResetFrame.Visible = false

	MenuResetRemote:FireServer()

	m_UserInterfaceHandler:HideAllFrames()
	m_UserInterfaceHandler:ShowFrame(MainScreenFrame)
	m_UserInterfaceHandler:ResetFrameRoad()

	HUDFrame.Visible = false
	HUD.Enabled = false
end)

ProgressYes:Click(function()
	if not m_UserInterfaceHandler.Debounce then return end
	m_UserInterfaceHandler.Debounce = false

	local status, message = Buy:InvokeServer(m_UserInterfaceHandler.Pressed)
	
	if not status then
		FailedUnlockLabel.Text = message
		m_SoundHandler:Play("Fail")

		m_UserInterfaceHandler.Debounce = true
		return m_UserInterfaceHandler:ShowFrame(FailedUnlockFrame)
	end

	m_SoundHandler:Play("Unlocking")
	SuccessfullUnlockLabel.Text = m_UserInterfaceHandler.Pressed

	m_UserInterfaceHandler.Debounce = true
	m_UserInterfaceHandler:ShowFrameRaw(SuccessfullUnlockFrame)
end)

MenuNoButton:Click(function()
	if not m_UserInterfaceHandler.Debounce then return end
	MenuResetFrame.Visible = false
end)

local isPlaying = true
VolumeButton:Click(function()
	isPlaying = not isPlaying
	handle_menu_sound(isPlaying)
end)

CurrentSelection:HoverStart(function()
	m_UserInterfaceHandler:HoverLabel(true, m_UserInterfaceHandler.CurrentSelection)
end)

CurrentSelection:HoverEnd(function()
	m_UserInterfaceHandler:HoverLabel(false)
end)

-- [[ HANDLING LOCKED / UNLOCKED DINOSAURS ]]

m_UserInterfaceHandler:DoLocks()
RedoLocks.OnClientEvent:Connect(function() m_UserInterfaceHandler:DoLocks() end)

ClientSelection.OnClientEvent:Connect(function(DinosaurName)
	m_UserInterfaceHandler:SelectDinosaur(DinosaurName)
end)

-- Handling sounds

Stamina:GetPropertyChangedSignal("Value"):Connect(function()
	StaminaFrame:TweenSize(
		UDim2.new(Stamina.Value, 0, 1, 0),
		Enum.EasingDirection.In, 
		Enum.EasingStyle.Linear,
		0.2
	)
end)

Hunger:GetPropertyChangedSignal("Value"):Connect(function()
	HungerFrame:TweenSize(
		UDim2.new(Hunger.Value, 0, 1, 0),
		Enum.EasingDirection.In, 
		Enum.EasingStyle.Linear,
		0.2
	)
end)

RunService:BindToRenderStep("CameraSway", Enum.RenderPriority.Camera.Value + 1, function(deltaTime)

	if Player:GetAttribute("SettingsCameraSway") then
			m_CameraSwayModule:Run(deltaTime) end

	m_HeadTurning.UpdateStatus()
	Player:SetAttribute("LookVector", Camera.CFrame)
end)

Player.CharacterRemoving:Connect(function()
	Controls(false)
end)

handle_menu_sound(true)

function growthLabel()
	local val = math.floor(Player.GrowthPercentage.Value)
	local stage = Player:GetAttribute("Growth")

	if not stage then return "NAn" end
	if stage == "Adult" then return "Adult" end
	
	if val > 0 then
		return val .. "% " .. stage
	else
		return stage
	end
end

coroutine.wrap(function()
	while task.wait() do
		GrowthBar.Text = growthLabel()
		if not m_UserInterfaceHandler.Hover then HoverLabel.Visible = false continue end

		local x, y = Mouse.X, Mouse.Y

		HoverLabel.Text = m_UserInterfaceHandler.Text
		HoverLabel.Position = UDim2.new(0, x, 0, y)
		HoverLabel.Visible = m_UserInterfaceHandler.Hover
	end
end)()