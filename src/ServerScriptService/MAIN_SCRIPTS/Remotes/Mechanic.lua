
-- Create the MechanicHandler module
local MechanicHandler = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Import the DinosaurService module
local DinosaurService = require(script.Parent.Parent.Dinosaur)

-- Mechanic Reset remote
local MechanicReset : RemoteEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ResetMechanic")

function MechanicHandler.Run(Player : Player, pos : number)
    local dstats = DinosaurService.GetStatsFromPlayer(Player)
    local Stamina : NumberValue = Player.Stamina

    local rs = {
        [0] = dstats.Speed,
        dstats.CrouchSpeed,
        dstats.RunSpeed,
        dstats.DashSpeed
    }

    Player:SetAttribute("p", pos)
    local rSpeed = rs[pos]

    Player.Character.Humanoid.WalkSpeed = Stamina.Value > 0 and rSpeed or rs[0]

    if Stamina.Value <= 0 then
        -- Reset anims and mechanic states
        MechanicReset:FireClient(Player)
    end

    return true
end

return MechanicHandler