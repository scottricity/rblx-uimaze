-- < Imports >
local Replicated = game:GetService("ReplicatedStorage")
local Fusion = require(Replicated.Fusion)

-- < Fusion Functions >
local New = Fusion.New
local Children = Fusion.Children
local Value = Fusion.Value
local Cleanup = Fusion.Cleanup
local ForValues = Fusion.ForValues
local ForKeys = Fusion.ForKeys
local ForPairs = Fusion.ForPairs
local Hydrate = Fusion.Hydrate
local Computed = Fusion.Computed
local doNothing = Fusion.doNothing

-- < Fusion Events >
local Observer = Fusion.Observer
local OnEvent = Fusion.OnEvent

-- < Fusion Types >
local Out = Fusion.Out
local Ref = Fusion.Ref

-- < Export >
local styles = {}
styles.Baseline = Fusion

return styles