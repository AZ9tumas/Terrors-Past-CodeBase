function Activate()
	if script.Parent.Parent.Active.Value == true and script.Parent.Parent.Power.Value == true then
		wait()
		wait(5)
		local g = script.Parent:GetChildren()
		for b = 1, 350 do
			for i = 1, # g do
				if g[i].className == "WedgePart" then
					g[i].CFrame = g[i].CFrame + Vector3.new(0, 0, -.02)
				end
			end
			wait(.025)
		end
		wait(2)
		script.Parent.Parent.Valid.Value = true
	elseif script.Parent.Parent.Active.Value == false then
		wait()
		local g = script.Parent:GetChildren()
		wait(2)
		for b = 1, 350 do
			for i = 1, # g do
				if g[i].className == "WedgePart" then
					g[i].CFrame = g[i].CFrame + Vector3.new(0, 0, .02)
				end
			end
			wait(.025)
		end
		wait(4)
		script.Parent.Parent.Valid.Value = true
	end
end

script.Parent.Parent.Active.Changed:connect(Activate)