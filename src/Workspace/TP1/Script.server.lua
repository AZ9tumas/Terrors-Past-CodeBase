local ClickDetector = script.Parent.ClickDetector
local TP = script.Parent.Parent.TP2


ClickDetector.MouseClick:Connect(function(plr)
plr.Character:MoveTo(TP.Position)



end)