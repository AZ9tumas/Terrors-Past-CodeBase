-- Server.Bite

local module = {}

local rayCastParams = RaycastParams.new()
rayCastParams.IgnoreWater = false
rayCastParams.FilterType = Enum.RaycastFilterType.Exclude

-- This script is required by RemoteEventHandler.lua
-- The event signals are also handled there.

module.ServerInvoke = function(plr : Player)
    print("Invoked by", plr)

    -- Raycast to find out who is being hit
    local Character = plr.Character
    if not Character then return end

    rayCastParams.FilterDescendantsInstances = Character:GetDescendants()

    local head : MeshPart = Character:WaitForChild("Head")
    local Humanoid : Humanoid = Character:WaitForChild("Humanoid")
    local HumanoidRootPart : MeshPart = Character:WaitForChild("HumanoidRootPart")
    local hitBox : Part = Character:WaitForChild("Hitbox")

    local dir = HumanoidRootPart.CFrame.LookVector * 2.5 -- head.CFrame:ToObjectSpace(CFrame.fromOrientation(0, -10, 10))

    -- Cast rays
    local downwardRay = workspace:Raycast(hitBox.Position, dir, rayCastParams)
    local blockcast = workspace:Blockcast(hitBox.CFrame, hitBox.Size, dir, rayCastParams)

    if blockcast and blockcast.Instance and blockcast.Instance.Parent and blockcast.Instance.Parent:FindFirstChildWhichIsA("Humanoid") then

        print(blockcast.Instance.Parent)

        local victim : Model = blockcast.Instance.Parent
        local victim_HumanoidRootPart = victim.PrimaryPart

        local victim_Humanoid : Humanoid = victim:FindFirstChildOfClass("Humanoid")

        victim_Humanoid:TakeDamage(2)

        local selection_box = Instance.new("SelectionBox", victim)
        selection_box.Adornee = victim
        selection_box.SurfaceTransparency = 1
        selection_box.Color3 = Color3.new(1, 0, 0)
        selection_box.LineThickness = 0.05

        -- Knockback
        local bodyforce = Instance.new("VectorForce", victim_HumanoidRootPart)
        bodyforce.Force = HumanoidRootPart.CFrame.LookVector * 150
        bodyforce.Attachment0 = victim_HumanoidRootPart:FindFirstAncestorOfClass("Attachment")

        -- Delete later
        task.delay(2.5, function()
            selection_box:Destroy()
            bodyforce:Destroy()
        end)
    end
end

return module