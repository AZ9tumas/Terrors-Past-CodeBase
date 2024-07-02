function Activate()
	if script.Parent.Parent.Active.Value == true and script.Parent.Parent.Power.Value == true then
		wait()
		wait(1)
		script.Parent.Parent.Frame.Sound.Sound:Play()
		wait(.3)
		script.Parent.Parent.Frame.Sound.Steam:Play()
		script.Parent.Parent.Frame.Smoke.Smoke.Enabled=true
		script.Parent.Parent.Frame.Smoke2.Smoke.Enabled=true
		script.Parent.Parent.Frame.Smoke3.Smoke.Enabled=true
		script.Parent.Parent.Frame.Smoke4.Smoke.Enabled=true
		script.Parent.Parent.Frame.Smoke5.Smoke.Enabled=true
		script.Parent.Parent.Frame.Smoke6.Smoke.Enabled=true
		script.Parent.Parent.Frame.Smoke7.Smoke.Enabled=true
		script.Parent.Parent.Frame.Smoke8.Smoke.Enabled=true
		wait(2.2)
		script.Parent.Parent.Frame.Sound.Sound:Play()
		wait(.3)
		script.Parent.Parent.Frame.Sound.Steam:Stop()
		script.Parent.Parent.Frame.Smoke.Smoke.Enabled=false
		script.Parent.Parent.Frame.Smoke2.Smoke.Enabled=false
		script.Parent.Parent.Frame.Smoke3.Smoke.Enabled=false
		script.Parent.Parent.Frame.Smoke4.Smoke.Enabled=false
		script.Parent.Parent.Frame.Smoke5.Smoke.Enabled=false
		script.Parent.Parent.Frame.Smoke6.Smoke.Enabled=false
		script.Parent.Parent.Frame.Smoke7.Smoke.Enabled=false
		script.Parent.Parent.Frame.Smoke8.Smoke.Enabled=false
		wait(1.2)
		script.Parent.Parent.Frame.Sound.OpenClose:Play()
		
		
		local g = script.Parent:GetChildren()
		for b = 1, 350 do
			for i = 1, # g do
				if g[i].className == "WedgePart" then
					g[i].CFrame = g[i].CFrame + Vector3.new(0, 0, .02)
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
		script.Parent.Parent.Frame.Sound.OpenClose:Play()
		for b = 1, 350 do
			for i = 1, # g do
				if g[i].className == "WedgePart" then
					g[i].CFrame = g[i].CFrame + Vector3.new(0, 0, -.02)
				end
			end
			wait(.025)
		end
		wait(.3)
		script.Parent.Parent.Frame.Sound.Steam:Play()
		script.Parent.Parent.Frame.Smoke.Smoke.Enabled=true
		script.Parent.Parent.Frame.Smoke2.Smoke.Enabled=true
		script.Parent.Parent.Frame.Smoke3.Smoke.Enabled=true
		script.Parent.Parent.Frame.Smoke4.Smoke.Enabled=true
		script.Parent.Parent.Frame.Smoke5.Smoke.Enabled=true
		script.Parent.Parent.Frame.Smoke6.Smoke.Enabled=true
		script.Parent.Parent.Frame.Smoke7.Smoke.Enabled=true
		script.Parent.Parent.Frame.Smoke8.Smoke.Enabled=true
		wait(2.2)
		script.Parent.Parent.Frame.Sound.Sound:Play()
		wait(.3)
		script.Parent.Parent.Frame.Sound.Steam:Stop()
		script.Parent.Parent.Frame.Smoke.Smoke.Enabled=false
		script.Parent.Parent.Frame.Smoke2.Smoke.Enabled=false
		script.Parent.Parent.Frame.Smoke3.Smoke.Enabled=false
		script.Parent.Parent.Frame.Smoke4.Smoke.Enabled=false
		script.Parent.Parent.Frame.Smoke5.Smoke.Enabled=false
		script.Parent.Parent.Frame.Smoke6.Smoke.Enabled=false
		script.Parent.Parent.Frame.Smoke7.Smoke.Enabled=false
		script.Parent.Parent.Frame.Smoke8.Smoke.Enabled=false
		wait(1.2)
		script.Parent.Parent.Valid.Value = true
	end
end

script.Parent.Parent.Active.Changed:connect(Activate)