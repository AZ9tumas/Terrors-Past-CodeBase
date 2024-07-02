-- Public Variables
local Module = {}
-- Private Variables
local Animations = {}

local CurrentAnimation = ''
local CurrentAnimationTrack : AnimationTrack = nil

local Character = script.Parent.Parent
local Player = game.Players:GetPlayerFromCharacter(Character)
local Humanoid = Character:WaitForChild('Humanoid')
local Animator : Animator = Humanoid:WaitForChild("Animator")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local AnimationFolder = Character:WaitForChild('AnimationsFolder')
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes : Folder = ReplicatedStorage:WaitForChild("Remotes")
local LoadAnimationsRemote : RemoteFunction = Remotes:WaitForChild("LoadAnimations")
local FootStepEvent = Remotes:WaitForChild("Footstep")

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Include
rayParams.FilterDescendantsInstances = {workspace.Terrain}
rayParams.IgnoreWater = false

local function CheckMaterial()
	local part = HumanoidRootPart
	local direction = Vector3.new(0, -10, 0)
	local result = workspace:Blockcast(part.CFrame, part.Size, direction, rayParams)
	
	if result and result.Instance then return result.Material == Enum.Material.Water end
end

function Module:OnKeyFrameReached(KeyFrameName, TrackName)
	if KeyFrameName == "Footstep" then
		local footstepName = (TrackName == "Run" or TrackName == "Dash") and "Running" or "Walking"
		
		local material = Humanoid.FloorMaterial
		--print(material)
		local CurrentMaterial = (CheckMaterial() and "Water" or material.Name) or "Ground"
		local fullName = footstepName.."_"..CurrentMaterial
		
		coroutine.wrap(function()
			FootStepEvent:FireServer(footstepName, CurrentMaterial)
		end)()
		
	end
end

function Module:LoadAnimations()
	AnimationFolder = LoadAnimationsRemote:InvokeServer()
	Module:UnloadAllAnimations()
	Animations = {}

	for _, anim in pairs(AnimationFolder:GetChildren()) do
		local track = Animator:LoadAnimation(anim)
		Animations[anim.Name] = track
		
		track.KeyframeReached:Connect(function(keyFrameName)
			Module:OnKeyFrameReached(keyFrameName, anim.Name)
		end)
		
	end
end

function Module:PlayAnimation(AnimationToPlay, AdjustSpeed, stopAll)
	--//If animation is already playing then return
	if Player.Swimming.Value then AnimationToPlay = "Swim" end
	if CurrentAnimation==AnimationToPlay and CurrentAnimationTrack.IsPlaying then return end
	
	--//Get Animation
	local AnimationTrack = Animations[AnimationToPlay]
	if not AnimationTrack then
		warn("Reloading", AnimationToPlay)

		local animation : Animation = AnimationFolder:FindFirstChild(AnimationToPlay)
		if not animation then
			Module:LoadAnimations()
		end

		-- Load this animation (Dynamic system)
		AnimationTrack[AnimationToPlay] = Animator:LoadAnimation(animation)

		return false, 0
	end
	CurrentAnimation = AnimationToPlay
	
	AnimationTrack:Play(0.35)
	
	--// Stop animations when required
	if stopAll then Module:StopAllAnimations() wait() end
	
	if CurrentAnimationTrack~=nil then CurrentAnimationTrack:Stop(0.35) end
	
	--// Adjust animation speed
	if AdjustSpeed then AnimationTrack:AdjustSpeed(AdjustSpeed) end
	CurrentAnimationTrack = AnimationTrack

	return true, AnimationTrack.Length
end

function Module:PlayRawAnimation(AnimationToPlay)
	--//If animation is already playing then return
	if CurrentAnimation==AnimationToPlay and CurrentAnimationTrack.IsPlaying then return false, 0 end
	--//Main Variables
	local AnimationTrack = Animations[AnimationToPlay]
	if not AnimationTrack then warn("AnimationError:", AnimationToPlay, "not found.") return false, 0 end
	
	AnimationTrack:Play(0.2)
	
	return true, AnimationTrack.Length, AnimationTrack
end

function Module:StopCurrentAnimation()
	if not (CurrentAnimation and CurrentAnimationTrack) then return warn("No animation is being played currently") end
	
	CurrentAnimationTrack:Stop()
	--print("["..CurrentAnimation.."] has been stopped.")
	CurrentAnimation = nil
end

function Module:GetAnimation(Name)
	if Animations[Name] and Animations[Name] ~= 0 then
		return true, Animations[Name]
	else
		return false
	end
end

function Module:StopAnimation(Name)
	for i,v in pairs(Animator:GetPlayingAnimationTracks())do
		if v.Animation.AnimationId==Animations[Name]then
			v:Stop()
			--print("["..v.Name.."] Animation Stopped.")
		end
	end
end

function Module:StopAllAnimations()
	local ActiveTracks = Animator:GetPlayingAnimationTracks()
	for _,v in pairs(ActiveTracks) do
		v:Stop()
	end
end

function Module:UnloadAllAnimations()
	if true then return end
	
	Animator:Destroy()
	Animator = Instance.new("Animator", Humanoid)

	local ActiveTracks = Animator:GetPlayingAnimationTracks()
	for _,v in pairs(ActiveTracks) do
		v:Destroy()
	end
end

function Module:IsAnimationBeingPlayed(AnimName)
	for i,v in pairs(Animator:GetPlayingAnimationTracks())do
		if v and Animations[AnimName] and "rbxassetid://"..Animations[AnimName] == v.Animation.AnimationId then
			return true
		end 
	end
	return false
end

return Module