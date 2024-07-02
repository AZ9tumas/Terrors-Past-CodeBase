function onClicked()
	if script.Parent.Parent.Power.Value == true then
		if script.Parent.Parent.Valid.Value == true then
			script.Parent.Parent.Valid.Value = false
			if script.Parent.Parent.Active.Value == false then
				script.Parent.Parent.Active.Value = true
			elseif script.Parent.Parent.Active.Value == true then
				script.Parent.Parent.Active.Value = false
			end
		end
	end
end

script.Parent.ClickDetector.MouseClick:connect(onClicked)