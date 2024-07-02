local jointInertia = {}

jointInertia.Connections = {}
jointInertia.InertiaJoints = {}

--Services
local RunService = game:GetService("RunService")

--Player
local camera = workspace.CurrentCamera

--Modules
local m_Settings = require(script:WaitForChild("Settings"))

local function getLODUpdateTime(root)
	local mag = (camera.CFrame.Position - root.Position).Magnitude
	if mag < m_Settings.MinimumLODDistance then
		return 0, 1
	else
		return m_Settings.LODUpdateRate, 2
	end
end

function jointInertia:Init()
	if self.Initialized then
		return
	else
		self.Initialized = true
		
		self.Connections.JointUpdate = RunService.Heartbeat:Connect(function(deltaTime)
			local scaledDeltaTime = math.clamp(10 * deltaTime, .04, .17)
			local snapshot = time()

			-- Inertia Joints

			for i,model in ipairs(jointInertia.InertiaJoints) do
				if model.RootPart and model.RootPart.Parent and model.RootPart.Parent.Parent ~= nil then
					local currentCF = model.RootPart.CFrame
					local lastRot = (model.LastCF - model.LastCF.Position)

					if snapshot - model.LastUpdate >= model.UpdateInterval then
						model.LastUpdate = snapshot
						local updateInterval, mult = getLODUpdateTime(model.RootPart)
						model.UpdateInterval = updateInterval

						-- Inertia Joints

						for _,v in ipairs(model.Joints) do
							--Update each individual joint

							--local goalCFrame, newY

							local goalCFrame = lastRot:ToObjectSpace(currentCF.Rotation):Inverse() + v.Joint.C0.Position
							local x,  y,  z = goalCFrame:ToOrientation()
							local xJ, yJ, zJ = v.Joint.C0:ToOrientation()

							local newY = math.clamp(y * v.Multiplier, math.rad(-v.MaxRotation), math.rad(v.MaxRotation))
							
							local newClampedGoalCFRame = CFrame.fromOrientation(xJ, newY, zJ) + v.Joint.C0.Position

							v.Joint.C0 = v.Joint.C0:Lerp(newClampedGoalCFRame, scaledDeltaTime * mult)
						end

						-- Neck Joints

						for _, v in ipairs(model.NeckJoints) do
							
							local curr = game.Players:GetPlayerFromCharacter(model.RootPart.Parent):GetAttribute("LookVector")
							local goal = lastRot:ToObjectSpace(curr.Rotation) + v.Joint.C0.Position
							local x,  y,  z = goal:ToOrientation()
							local xJ, yJ, zJ = v.Joint.C0:ToOrientation()

							local newY = math.clamp(y / 4, math.rad(-45), math.rad(45))
							local newClampedGoalCFRame = CFrame.fromOrientation(x * 1/2, newY, zJ) + v.Joint.C0.Position

							v.Joint.C0 = v.Joint.C0:Lerp(newClampedGoalCFRame, scaledDeltaTime * mult)
						end
					end

					model.LastCF = model.RootPart.CFrame
				else
					--Rootpart does not exist, remove from the queue
					table.remove(jointInertia.InertiaJoints, i)
				end
			end
		end)
	end
end

function jointInertia:Pause()
	if not self.Initialized then
		return
	else
		if self.Connections.JointUpdate then
			self.Connections.JointUpdate:Disconnect()
			self.Connections.JointUpdate = nil
		end
		
		self.Initialized = false
	end
end

function jointInertia:Add(model)
	local root = model:FindFirstChild("HumanoidRootPart")
	if root then
		--Check if model is already in the table
		for _,v in ipairs(jointInertia.InertiaJoints) do
			if v.RootPart.Parent == model then
				return
			end
		end
		
		local newIndex = {}
		newIndex.Joints = {}
		newIndex.NeckJoints = {}
		newIndex.RootPart = root
		newIndex.LastCF = root.CFrame
		newIndex.LastUpdate = time()
		newIndex.UpdateInterval = getLODUpdateTime(root)

		for i,v in pairs(model:GetDescendants()) do
			if v:IsA("Motor6D") and (v.Name == m_Settings.InertiaJointName or string.match(v.Parent.Name, m_Settings.NeckJointName)) then

				-- Separate NeckJoints
				
				local newJoint = {}
				newJoint.Joint = v
				newJoint.MaxRotation = v:GetAttribute("MaxRotation") or m_Settings.DefaultMaxRotation
				newJoint.Multiplier = v:GetAttribute("Multiplier") or m_Settings.DefaultMultiplier
				
				if not v:GetAttribute("OriginalC0") then
					v:SetAttribute("OriginalC0", v.C0)
				end
				
				table.insert(string.match(v.Parent.Name, m_Settings.NeckJointName) and newIndex.NeckJoints or newIndex.Joints, newJoint)

			end
		end
		
		if #newIndex.Joints > 0  then
			table.insert(jointInertia.InertiaJoints,newIndex)
			print("Regestired a new set of joints")
			print(newIndex)
		else
			print("No inertia joints.")
		end
	else
		print("No root part")
	end
end

function jointInertia:Remove(model)
	for i,v in ipairs(jointInertia.InertiaJoints) do
		if v.RootPart.Parent == model then
			
			for _,v in ipairs(v.Joints) do
				v.Joint.C0 = v.Joint:GetAttribute("OriginalC0")
				v.Joint:SetAttribute("OriginalC0", nil)
			end
			
			return table.remove(jointInertia.InertiaJoints,i)
		end
	end
end


return jointInertia
