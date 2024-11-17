package Engine.Interface.Editor.Behaviors {

import Display.Text.SimpleText;
import Display.Util.ColorUtil;
import Display.Util.GraphicsUtil;
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
    public var editTypes:Array;
    private var parameters:Vector.<Sprite>;

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
        editTypes = [false];
        PARAMETERS = [this.wander.speed];
    }

    private function addParams():void
    {
        this.parameters = new Vector.<Sprite>();
        for (var i:int = 0; i < PARAMETERS.length; i++)
        {
            if (editTypes[i])
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
        this.container = GraphicsUtil.drawTransparentWindow(105, 35, ColorUtil.PASSIVE_COLOR);
        addChild(this.container);

        this.inset = GraphicsUtil.drawTransparentWindow(Editor.INSET_WIDTH - 125, 35, ColorUtil.PASSIVE_COLOR_ALT);
        this.inset.x = 105;
        addChild(this.inset);
    }
}
}
