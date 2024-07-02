export type ButtonType = {
    new : ButtonType,
	ClickEvent : RBXScriptSignal,
	HoverStartEvent : RBXScriptSignal,
	HoverEndEvent : RBXScriptSignal,
    Click : RBXScriptSignal,
	HoverStart : RBXScriptSignal,
	HoverEnd : RBXScriptSignal,
    Button : ButtonType,
    Events : { [string] : RBXScriptSignal },
    ClickFunction : any,
    HoverStartFunction : any,
    HoverEndFunction : any
}

local m_SoundHandler = require(script.Parent.Parent:WaitForChild("SoundHandler"))
m_SoundHandler:LoadSounds()

local button : ButtonType = {}
button.__index = button

function button.new(givenButton : ImageButton | TextButton) : ButtonType
    local newButton = {}
    setmetatable(newButton, button)

    newButton.Button = givenButton
    
    newButton.Events = {
        ["Click"] = givenButton.MouseButton1Click,
        ["HoverStart"] = givenButton.MouseEnter,
        ["HoverEnd"] = givenButton.MouseLeave
    }

    newButton.ClickFunction = nil
    newButton.HoverStarFunction = nil
    newButton.HoverEndFunction = nil

    newButton.ClickEvent = newButton.Events["Click"]:Connect(function()
        m_SoundHandler:Play("Click")
        if newButton.ClickFunction then newButton.ClickFunction() end
        
    end)

    newButton.HoverStartEvent = newButton.Events["HoverStart"]:Connect(function()
        m_SoundHandler:Play("Hover")
        if newButton.HoverStarFunction then newButton.HoverStarFunction() end
    end)

    newButton.HoverEndEvent = newButton.Events["HoverEnd"]:Connect(function()
        if newButton.HoverEndFunction then newButton.HoverEndFunction() end
    end)

    return newButton
end

function button:Click(exec)
    self.ClickFunction = exec
    return self.ClickEvent
end

function button:HoverStart(exec)
    self.HoverStartFunction = exec
    return self.HoverStartEvent
end

function button:HoverEnd(exec)
    self.HoverEndFunction = exec
    return self.HoverEndEvent
end

return button