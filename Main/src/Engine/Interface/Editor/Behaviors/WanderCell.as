package Engine.Interface.Editor.Behaviors {

import Display.Text.SimpleText;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.Behavior;

import Engine.Behaviors.Modals.Shoot;
import Engine.Behaviors.Modals.Wander;
import Engine.Interface.Editor;
import Engine.Interface.Editor.Behaviors.BehaviorCell;
import Engine.Interface.Editor.CellCheck;
import Engine.Interface.Editor.CellParameter;
import Engine.Interface.Editor.States.StateCell;

import flash.display.Sprite;

public class WanderCell extends BehaviorCell {

    public var wander:Wander;
    public var actionText:SimpleText;
    private var parameters:Vector.<Sprite>;

    public var CHECK:Array;

    public function WanderCell(index:int, host:StateCell, behavior:Behavior) {
        super(index, host, behavior);
        if (!behavior is Wander)
            return;

        var wander:Wander = behavior as Wander;
        this.wander = wander;

        drawBackground();
        addHeader();
        setParams();
        addParams();
    }

    private function addHeader():void
    {
        this.actionText = new SimpleText(14, 0xaaaaaa, false);
        this.actionText.x = this.actionText.y = 6;
        TextUtil.handleText(this.actionText, "new <font color=\"#ffffff\">Wander</font>:", this);
    }

    private function setParams():void
    {
        CHECK = [false];
        PARAMETERS = [this.wander.speed];
    }

    private function addParams():void
    {
        this.parameters = new Vector.<Sprite>();
        for (var i:int = 0; i < PARAMETERS.length; i++)
        {
            if (CHECK[i])
                this.parameters[i] = new CellCheck(this, i);
            else
                this.parameters[i] = new CellParameter(this, i);
            this.parameters[i].x = 115;
            this.parameters[i].y = 7;
            addChild(this.parameters[i]);
            this.parameters.push(this.parameters[i]);
        }
    }

    private function drawBackground():void
    {
        graphics.clear();
        graphics.beginFill(0x2b2b2b, 1);
        graphics.lineStyle(2, 0x151515);
        graphics.drawRoundRect(0, 0, Editor.INSET_WIDTH - 20, 35, 15, 15);
        graphics.endFill();
        graphics.beginFill(0x151515, 1);
        graphics.drawRoundRect(0, 0, 20, 35, 15, 15);
        graphics.endFill();
        graphics.beginFill(0x151515, 1);
        graphics.drawRect(8, 0, 95, 35);
        graphics.endFill();
    }
}
}
