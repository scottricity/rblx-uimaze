-- Baseline is Fusion
local Styles = require(script.Parent)
local Baseline = Styles.Baseline

-- < Fusion Shortcuts >
local New = Baseline.New
local OnEvent = Baseline.OnEvent

return function(props: Styles.Props)
    return New "TextButton" {
        Size = UDim2.new(.3,0,.1,0);
        Name = "TestButton";
        Text = "Hm";
        [OnEvent "Activated"] = function()
            if not props.Disabled:get() then
                if props.OnClick then
                    props.OnClick()
                end
            end
        end;
    }
end