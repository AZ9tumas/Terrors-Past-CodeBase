local WaveWalker = require(script.Parent.WaveCalculator)

local WavesBindable = game.ReplicatedStorage.Bindable.GetWaves

WavesBindable.Event:Connect(function(inst)
	local player = game.Players:GetPlayerFromCharacter(inst)
	if not player then return end
	
	if not player.Swimming.Value then return end
	
	local pos = inst.HumanoidRootPart.Position
	local y = WaveWalker:calcWaterHeightOffset(pos.X, pos.Z)
	local c = CFrame.new(Vector3.new(pos.X, pos.Y + y, pos.Z), inst.HumanoidRootPart.CFrame.LookVector)
	inst:SetPrimaryPartCFrame(c)
end)