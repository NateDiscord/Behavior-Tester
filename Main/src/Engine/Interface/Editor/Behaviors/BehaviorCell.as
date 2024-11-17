package Engine.Interface.Editor.Behaviors {
import Display.Util.ColorUtil;
import Display.Util.ColorUtil;
import Display.Util.GraphicsUtil;

import Engine.Behaviors.Modals.Behavior;
import Engine.Interface.Editor;
import Engine.Interface.Editor.States.StateCell;

import flash.display.Sprite;

public class BehaviorCell extends Sprite {

    public var PARAMETERS:Array;

    public var index:int;
    public var stateCell:StateCell;
    public var behavior:Behavior;

    public var container:Sprite;
    public var inset:Sprite;

    public static const SHOOT:Array = [90, ColorUtil.HOSTILE_COLOR, ColorUtil.HOSTILE_COLOR_ALT];
    public static const WANDER:Array = [35, ColorUtil.PASSIVE_COLOR, ColorUtil.PASSIVE_COLOR_ALT];
    public static const NEW:Array = [35, ColorUtil.NEW_COLOR, ColorUtil.NEW_COLOR_ALT];

    public var data:Array;

    public function BehaviorCell(index:int, host:StateCell, behavior:Behavior) {
        this.index = index;
        this.stateCell = host;
        this.behavior = behavior;

        if (behavior != null)
            switch (behavior.action)
            {
                case "shoot": this.data = SHOOT; break;
                case "wander": this.data = WANDER; break;
            }
        else
            this.data = NEW;
        this.drawBackground(this.data);
    }

    private function drawBackground(arr:Array):void
    {
        this.container = GraphicsUtil.drawTransparentWindow(105, arr[0], arr[1]);
        addChild(this.container);

        this.inset = GraphicsUtil.drawTransparentWindow(Editor.INSET_WIDTH - 125, arr[0], arr[2]);
        this.inset.x = 105;
        addChild(this.inset);
    }
}
}
