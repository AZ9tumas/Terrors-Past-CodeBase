local module = {}

module.Description = "clears the current terminal"

module.Params = {}

function module.run(params)
    -- ignore params

    for _, v in pairs(game.Players.LocalPlayer.PlayerGui.C.Frame.ScrollingFrame:GetChildren()) do
        if v:IsA("TextLabel") or v:IsA("Frame") then
            v:Destroy()
        end
    end

    return true
end

return module