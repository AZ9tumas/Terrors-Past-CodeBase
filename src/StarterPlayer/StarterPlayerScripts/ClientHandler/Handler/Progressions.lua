local module = {}

-- [[ SERVICES ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- [[ PLAYER PARAMS ]]
local Player : Player = Players.LocalPlayer

-- [[ SCREEN GUI ]]
local PlayerGui = Player:WaitForChild("PlayerGui")
local MenuUI = PlayerGui:WaitForChild("MenuUI")

-- [[ UI COMPONENTS ]]
local ProgressScreen : Frame = MenuUI:WaitForChild("ProgressScreen")
local ProgressFrame = ProgressScreen:WaitForChild("Progress")
local ProgressLabel : TextLabel = ProgressFrame:WaitForChild("Progress")
local PrevDinoLabel : TextLabel = ProgressFrame:WaitForChild("PrevDino")
local PointsLabel : TextLabel = ProgressFrame:WaitForChild("SomePoints")
local SpecificTaskLabel : TextLabel = ProgressFrame:WaitForChild("SpecificTask")

-- [[ MODULES ]]
local m_Settings = require(ReplicatedStorage:WaitForChild("DinosaurDivisions"))
local m_UtilityModule = require(ReplicatedStorage:WaitForChild("DinosaurStatsUtilityModule"))

function module:SetUpProgressionsFrame(DinosaurName)
	-- prevDino = "Adult of prev dino"
	-- progress = "Progress to this dinosaur"
	
	local previous_dino = m_Settings.GetBranchingDinosaur(DinosaurName)

	if not previous_dino then
		ProgressLabel.Text = "UNAVAILABLE"
		PrevDinoLabel.Text = "THERE IS NO PREVIOUS DINOSAUR"
		return
	end
	
	ProgressLabel.Text = "Progress to " .. DinosaurName
	PrevDinoLabel.Text = "Adult of " .. previous_dino
	PointsLabel.Text = "Points Required: " .. m_UtilityModule.getDinosaurCost(DinosaurName)
	SpecificTaskLabel.Text = ""
end

return module
