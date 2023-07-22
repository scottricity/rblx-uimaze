local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
ReplicatedFirst:RemoveDefaultLoadingScreen()

local _Loaded = Instance.new("BindableEvent")
_Loaded.Name = "_Loaded"
_Loaded.Parent = ReplicatedStorage

-- < Fusion Functions >
local Fusion = require(ReplicatedStorage:WaitForChild("Fusion"))

local New = Fusion.New
local Children = Fusion.Children
local Value = Fusion.Value
local Observer = Fusion.Observer
local OnEvent = Fusion.OnEvent
local Out = Fusion.Out

task.wait(3)
_Loaded:Fire()