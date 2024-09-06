package Engine.Interface.Editor {
import Display.Text.SimpleText;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.Shoot;

import flash.display.Sprite;

public class BehaviorCell extends Sprite {

    public var PARAMETERS:Array;

    public var index:int;
    public var host:StateCell;

    public function BehaviorCell(index:int, host:StateCell) {
        this.index = index;
        this.host = host;
    }
}
}
