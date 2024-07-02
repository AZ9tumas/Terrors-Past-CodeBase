local module = {}

-- [[ SERVICES ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- [[ PLAYER PARAMS ]]
local Player : Player = Players.LocalPlayer

-- [[ REMOTES ]]
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

-- [[ SCREEN GUI ]]
local PlayerGui = Player:WaitForChild("PlayerGui")
local MenuUI = PlayerGui:WaitForChild("MenuUI")

-- [[ FRAMES ]]
local MainScreenFrame : Frame = MenuUI:WaitForChild("MainScreen")
local BlackScreen1 : Frame = MenuUI:WaitForChild("Black1")
local BlackScreen2 : Frame = MenuUI:WaitForChild("Black2")

local CarnivoresFrame = MenuUI:WaitForChild("Carnivores")
local HerbivoresFrame = MenuUI:WaitForChild("Herbivores")
local OmnivoresFrame = MenuUI:WaitForChild("Omnivores")
local PterosaursFrame = MenuUI:WaitForChild("Pterosaurs")
local Lock : Frame = CarnivoresFrame:WaitForChild("Lock")
local ProgressScreen : Frame = MenuUI:WaitForChild("ProgressScreen")
local DinoSelectionbase = MenuUI:WaitForChild("DinoSelectionBase")
local BookletBaseFrame = MenuUI:WaitForChild("BookletBase")
local Booklet = BookletBaseFrame:WaitForChild("Booklet")

-- [[ BUTTONS ]]
local Back : ImageButton = MenuUI:WaitForChild("Back")

-- [[ OTHER UI INSTANCES ]]
local CurrentSelectionButton = MainScreenFrame:WaitForChild("CurrentSelection")
local SelectLabel : TextLabel = DinoSelectionbase:WaitForChild("Dino"):WaitForChild("Text")
-- [[ MODULES ]]
local m_Button = require(script:WaitForChild("Button"))
local m_Settings = require(ReplicatedStorage:WaitForChild("DinosaurDivisions"))
local m_Progressions = require(script:WaitForChild("Progressions"))
local m_UtilityModule = require(ReplicatedStorage:WaitForChild("DinosaurStatsUtilityModule"))
local m_SoundHandler = require(script.Parent:WaitForChild("SoundHandler"))

-- [ MODULE PARAMETERS[]]

module.FramesVisited = {}
module.LockedConnections = {}
module.UnlockedConnections = {}
module.CurrentFrame = MainScreenFrame
module.CurrentSelection = nil
module.Hover = false
module.Debounce = true
module.Pressed = nil

module.Carnivores = m_Settings.Carnivores
module.Herbivores = m_Settings.Herbivores
module.Omnivores = m_Settings.Omnivores
module.Pterosaurs = m_Settings.Pterosaurs

function module:ResetFrameRoad()
	module.FramesVisited = {}
	module.CurrentFrame = MainScreenFrame
	module:HandleBackButton()
end

function module:HoverLabel(val, text)
	module.Hover = val
	module.Text = text or ""
end

function module:HideAllFrames()
	for _, child in pairs(MenuUI:GetChildren()) do
		if child:IsA("Frame") and child ~= BlackScreen1 and child ~= BlackScreen2 then child.Visible = false end
	end
end

function module:FadeBlackScreen(Time, status)
	Time = Time or 0.5
	
	BlackScreen1:TweenPosition(UDim2.new(status and 0.5 or 1, 0, 0, 0), 
		Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, Time)
	BlackScreen2:TweenPosition(UDim2.new(not status and -0.5 or 0, 0, 0, 0), 
		Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, Time)
	
	return Time
end

function module:ShowFrameRaw(Frame, Time)
	if not module.Debounce then return end
	module.Debounce = false

	wait(module:FadeBlackScreen(0.25, true))
	module:HideAllFrames()

	module.CurrentFrame = Frame
	module.CurrentFrame.Visible = true
	
	wait(Time or 0.01)
	wait(module:FadeBlackScreen(0.25, false))
	module.Debounce = true
end

function module:ShowFrame(Frame, goingback, Time)
	if not module.Debounce then return end
	module.Debounce = false

	wait(module:FadeBlackScreen(0.25, true))
	module:HideAllFrames()
	
	if goingback then
		-- If we are going back to the previous frame,
		-- We remove the current frame that is visible.
		table.remove(module.FramesVisited, #module.FramesVisited)
	else
		-- We are going to another frame now, so add it to the road
		table.insert(module.FramesVisited, module.CurrentFrame)
	end

	module.CurrentFrame = Frame
	module.CurrentFrame.Visible = true

	module:HandleBackButton()
	wait(Time or 0.01)
	wait(module:FadeBlackScreen(0.25, false))
	module.Debounce = true
end

function module:HandleBackButton()
	Back.Visible = #module.FramesVisited ~= 0
end

function module:SelectDinosaur(DinosaurName)
	module.CurrentSelection = DinosaurName
	
	CurrentSelectionButton.Image = MenuUI:WaitForChild(m_UtilityModule.getDinosaurType(DinosaurName)):WaitForChild(DinosaurName).Image
	CurrentSelectionButton.Visible = true
end

function module:GetUnlockedDinosaurs()
	return {
		c = m_Settings.GetDinosaursFromIndexes("Carnivores", Player:GetAttribute("Carnivores")), 
		h = m_Settings.GetDinosaursFromIndexes("Herbivores", Player:GetAttribute("Herbivores")), 
		o = m_Settings.GetDinosaursFromIndexes("Omnivores", Player:GetAttribute("Omnivores")), 
		--p = m_Settings.GetDinosaursFromIndexes("Pterosaurs", Players:GetAttribute("Pterosaurs"))
	}
end

local function addLock(button)
	local newLock = Lock:Clone()
	newLock.Visible = true
	newLock.Parent = button
end

local function removeLock(button)
	if button:FindFirstChild("Lock") then
		button.Lock:Destroy()
	end
end

function module:DoLocks()
	-- reset all connections
	for _, v : RBXScriptSignal in pairs(module.LockedConnections) do v:Disconnect() end
	for _, v : RBXScriptSignal in pairs(module.UnlockedConnections) do v:Disconnect() end
	
	local UnlockedDinosaurs = module:GetUnlockedDinosaurs()

	local categories = {
		{frame = CarnivoresFrame, unlocked = UnlockedDinosaurs.c},
		{frame = HerbivoresFrame, unlocked = UnlockedDinosaurs.h},
		{frame = OmnivoresFrame , unlocked = UnlockedDinosaurs.o},
		--{frame = PterosaursFrame, unlocked = UnlockedDinosaurs.p}
	}

	for _, category in pairs(categories) do
		for _, button in pairs(category.frame:GetChildren()) do
			if not button:IsA("ImageButton") then continue end
			
			removeLock(button)
			
			if table.find(category.unlocked, button.Name) then
				module:UnlockButton(button)
			else
				addLock(button)
				module:LockButton(button)
			end
		end
	end
end

function module:UnlockButton(b) : RBXScriptConnection
	-- sets up creature icons which can be selected.
	local newButton = m_Button.new(b)
	
	module.UnlockedConnections[b.Name] = newButton:Click(function()
		if not module.Debounce then return end
		if b:FindFirstChild("BookletId") then Booklet.Image = "rbxassetid://" .. b.BookletId.Value end
		
		SelectLabel.Text = b.Name
		module:ShowFrame(BookletBaseFrame)
		module.Pressed = b.Name
	end)

	newButton:HoverStart(function()end)
end

function module:LockButton(b) : RBXScriptConnection
	-- sets up creature icons which can be bought.
	local new = m_Button.new(b)

	module.LockedConnections[b.Name] = new:Click(function()
		if not module.Debounce then return end
		
		module.Pressed = b.Name
		m_Progressions:SetUpProgressionsFrame(b.Name)
		m_SoundHandler:Play("AreYouSure")
		module:ShowFrame(ProgressScreen)

		-- setup the progression frame

	end)

	new:HoverStart(function()end)
end

return module