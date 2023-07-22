local PlayerGui = script.Parent
local Replicated = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- < Dependencies >
local Fusion = require(Replicated.Fusion)
local FusionTypes = require(Replicated.Fusion.Types)
local FusionPubTypes = require(Replicated.Fusion.PubTypes)
local GuiCollisionService = require(Replicated.GuiCollisionService)
local WaitFor = require(Replicated.WaitFor)

-- < Styles/Components Import >
--[[
    At the moment, this is not used. It's meant to hold bigger and more complex components (size wise).
]]
local StylesImport = PlayerGui:WaitForChild("Styles")
local Styles = require(StylesImport)

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
local OnChange = Fusion.OnChange

-- < Fusion Types >
local Out = Fusion.Out
local Ref = Fusion.Ref

-- < Main Program >
local Client = Players.LocalPlayer
Replicated:WaitForChild("_Loaded").Event:Wait() -- Wait for the event named "_Loaded" in ReplicatedFirst to fire, telling us we can start creating UIs

-- < Client Mouse Method >
local Mouse = Client:GetMouse()
local mX, mY = Mouse.X, Mouse.Y
local MousePosition = Value(UDim2.new(0,mX,0,mY))
Mouse.Move:Connect(function()
    mX = Mouse.X
    mY = Mouse.Y
    MousePosition:set({mX, mY}) -- This is not used directly, it's a hacky way to send an event to Fusion's event objects
end)

-- < Player Properties >
local PlayerPosition = Observer(MousePosition) -- Observe the client's mouse and fire when it changes
local IsAlive = Value(true) 
local _Player = Value() -- This is the cursor/player UI instance, to use globally in this script

-- < Player Component (cursor) >
local function Player(props)
    local _pos = Value(UDim2.new(0,0,0,0))
    local dragging = Value(false)

    local Size = UDim2.new(0.06,0,0.06,0)

    PlayerPosition:onChange(function()
        if dragging:get() then
            _pos:set(UDim2.new(0,mX - 30,0,mY))
        end
    end)

    return New "ImageButton" {
        [Ref] = _Player;
        Name = "Cursor";
        Position = _pos;
        Size = Size;
        SizeConstraint = Enum.SizeConstraint.RelativeXX;
        ImageTransparency = 1;
        ZIndex = 2;
        [OnEvent "MouseButton1Down"] = function(_, clicks)
            dragging:set(true)
        end;
        [OnEvent "MouseButton1Up"] = function(_, clicks)
            dragging:set(false)
        end;
        [Children] = {
            New "UICorner" {
                CornerRadius = UDim.new(.1,0)
            }
        };
    }
end

-- < Game >
local Main: ScreenGui= New "ScreenGui" {
    Name = "Main";
    Parent = PlayerGui;
    IgnoreGuiInset = true;
    ZIndexBehavior = Enum.ZIndexBehavior.Global;
    [Children] = {
        New "Frame" {
            Name = "Container";
            Size = UDim2.new(1,0,1,0);
            BackgroundTransparency = 1;
            [Children] = {
                Player {};
            }
        };
    };
}

print(_Player:get())

