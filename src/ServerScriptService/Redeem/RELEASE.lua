local module = {}

-- [[ SERVICES ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- [[ BINDABLES ]]
local Bindables = ReplicatedStorage:WaitForChild("Bindable")
local GetData : BindableFunction = Bindables:WaitForChild("Get")
local SetData : BindableEvent = Bindables:WaitForChild("Set")
local IncrementData : BindableEvent = Bindables:WaitForChild("Increment")

-- [[ REMOTES ]]
local Remotes : Folder = ReplicatedStorage:WaitForChild("Remotes")

function module:InvokeCode(Player : Player)
    -- add 600 progression points
    Player.leaderstats.Points.Value += 600
    -- IncrementData:Fire(Player, "Points", 600)
end

return module