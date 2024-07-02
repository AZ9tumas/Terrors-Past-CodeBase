local module = {}

local m_PrimaryAttack = require(script.Parent.Parent:WaitForChild("PrimaryAttack"))

function module.CheckInputType(InputType : InputObject)
    if InputType.UserInputType == Enum.UserInputType.MouseButton1 then
        module.PrimaryAttack()
    elseif InputType.UserInputType == Enum.UserInputType.MouseButton2 then
        module.SecondaryAttack()
    end
end

function module.PrimaryAttack()

    -- Invoke primary attack method / ability
    m_PrimaryAttack.Invoke()
end

function module.SecondaryAttack()
    
end

return module