package Engine.Interface.Editor.Behaviors {
import Engine.Behaviors.Modals.Behavior;
import Engine.Interface.Editor.States.StateCell;

import flash.display.Sprite;

public class BehaviorCell extends Sprite {

    public var PARAMETERS:Array;

    public var index:int;
    public var stateCell:StateCell;
    public var behavior:Behavior;

    public function BehaviorCell(index:int, host:StateCell, behavior:Behavior) {
        this.index = index;
        this.stateCell = host;
        this.behavior = behavior;
    }
}
}
