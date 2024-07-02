
local module = {}

-- [[ SERVICES ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- [[ BINDABLES ]]
local Bindables = ReplicatedStorage:WaitForChild("Bindable")
local GetData : BindableFunction = Bindables:WaitForChild("Get")
local SetData : BindableEvent = Bindables:WaitForChild("Set")

-- [[ REMOTES ]]
local Remotes : Folder = ReplicatedStorage:WaitForChild("Remotes")
local RedoLocks : RemoteEvent = Remotes:WaitForChild("RedoLocks")

function module:InvokeCode(Player : Player)
    return true
    --[[
    -- Add Ceratosaurus to their inventory
    local carnivores : string = GetData:Invoke(Player, "Carnivores", "b1")

    if not table.find(carnivores:split("-"), "7") then
        SetData:Fire(Player, "Carnivores", carnivores.."-7")
        print(carnivores.."-7")
        RedoLocks:FireClient(Player)
    else
        print("Player already has Ceratosaurus in their inventory.")
    end

    return true]]
end


return module