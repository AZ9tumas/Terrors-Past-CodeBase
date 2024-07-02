
local DinosaurService = require(script.Parent.Parent.Dinosaur)
local Players = game:GetService("Players")
local Steps : Folder = game:GetService("ReplicatedStorage"):WaitForChild("Footstep")

local FootstepHandler = {}

function FootstepHandler.HandleFootsteps(Character : Model)
    -- this is called after player is done morphing
    local hrp : BasePart = Character:WaitForChild("HumanoidRootPart")
    -- get the footstep type
    local Player : Player = Players:GetPlayerFromCharacter(Character)
    -- all stats
    local stats = DinosaurService.GetStatsFromPlayer(Player)
    local _type = stats.FootstepSize
    
    -- Iterate over the step types (large, medium, small)
    for _, stepType in pairs(Steps[_type]:GetChildren()) do
        -- Iterate over the ground types (running, walking)
        for _, groundType in pairs(stepType:GetChildren()) do
            -- Get the sounds for the current ground type
            local sounds = groundType:GetChildren()
            
            -- Create four sound instances for each ground type
            for a = 1, 4 do
                local sound = Instance.new("Sound", hrp)
                sound.Name = string.format("%s_%s_%d", stepType.Name, groundType.Name, a)
                sound.SoundId = sounds[a].SoundId
            end
        end
    end

    -- exit status = 1
    return true
end

function FootstepHandler.Call(Player : Player, stepType : string, groundType : string)
    -- steptype = "Running" or "walking"
    groundType = groundType or "Ground"
    local hrp = Player.Character.HumanoidRootPart
    local stepName = stepType .. "_" .. groundType

    --if not hrp:FindFirstChild(stepName).."_1" then stepName = stepType .. "_Ground" end
    stepName = hrp:FindFirstChild(stepName.."_1") and stepName or stepType .. "_Ground"

    local stats = DinosaurService.GetStatsFromPlayer(Player)
    local volume = stats.FootstepVolume

    local sounds = {}
    for a = 1, 4 do sounds[a] = hrp[stepName .. "_" .. a] end -- here

    local sound : Sound = sounds[math.random(#sounds)]

    sound.Volume = volume

    sound:Play()

	return true
end

return FootstepHandler