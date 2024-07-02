wait()
for _, v in pairs(script.Parent:GetChildren()) do
	if not v:IsA("Script") then
		-- add prompts
		--local prompt = Instance.new("ProximityPrompt", v)
		local thing = script.Prompt:Clone()
		thing.Parent = v
		thing.ActionText = "Tier "..v.Name:sub(#v.Name, #v.Name).." Meat"
	end
end