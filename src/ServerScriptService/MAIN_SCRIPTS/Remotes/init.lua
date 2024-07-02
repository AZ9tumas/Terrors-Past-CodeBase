-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:Getservice("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- Body Movers
local BodyMovers = ReplicatedStorage:WaitForChild("BodyMovers")
local BodyPosition = BodyMovers:WaitForChild("BodyPosition")
local AngularVelocity = BodyMovers:WaitForChild("AngularVelocity")

-- Bindables
local Bindable : Folder = ReplicatedStorage:WaitForChild("Bindable")
local Get : BindableFunction = Bindable:WaitForChild("Get")
local Set : BindableEvent = Bindable:WaitForChild("Set")

-- Folders
local Events = ReplicatedStorage:WaitForChild("Remotes")
local StatScripts = ServerScriptService:WaitForChild("Dinosaurs")

local Get : BindableFunction = Bindable:WaitForChild("Get")
local Set : BindableEvent = Bindable:WaitForChild("Set")
