package Engine.Interface.Editor.Behaviors {

import Display.Text.SimpleText;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.Behavior;

import Engine.Behaviors.Modals.Shoot;
import Engine.Interface.Editor;
import Engine.Interface.Editor.Behaviors.BehaviorCell;
import Engine.Interface.Editor.CellCheck;
import Engine.Interface.Editor.CellParameter;
import Engine.Interface.Editor.ProjChooser;
import Engine.Interface.Editor.States.StateCell;

import flash.display.Sprite;

public class ShootCell extends BehaviorCell {

    public var shoot:Shoot;
    public var actionText:SimpleText;
    private var parameters:Vector.<Sprite>;

    public var CHECK:Array;

    public function ShootCell(index:int, host:StateCell, behavior:Behavior) {
        super(index, host, behavior);
        if (!behavior is Shoot)
            return;

        var shoot:Shoot = behavior as Shoot;
        this.shoot = shoot;

        drawBackground();
        addHeader();
        setParams();
        addParams();
        positionParams();
    }

    private function addHeader():void
    {
        this.actionText = new SimpleText(14, 0xaaaaaa, false);
        this.actionText.x = this.actionText.y = 6;
        TextUtil.handleText(this.actionText, "new <font color=\"#ffffff\">Shoot</font>:", this);
    }

    private function setParams():void
    {
        CHECK = [0,0,0,0,0,2,1];
        PARAMETERS = [this.shoot.shots, this.shoot.angle, this.shoot.fixedAngle, this.shoot.coolDown, this.shoot.msOffset, this.shoot.projectileIndex, this.shoot.predictive];
    }

    private function addParams():void
    {
        this.parameters = new Vector.<Sprite>();
        for (var i:int = 0; i < PARAMETERS.length; i++)
        {
            switch (CHECK[i])
            {
                case 0: this.parameters[i] = new CellParameter(this, i); break;
                case 1: this.parameters[i] = new CellCheck(this, i); break;
                case 2: this.parameters[i] = new ProjChooser(this); break;
                default: return;
            }
            addChild(this.parameters[i]);
            this.parameters.push(this.parameters[i]);
        }
    }

    private function positionParams():void
    {
        this.parameters[0].x = 10;
        this.parameters[0].y = 36;
        this.parameters[1].x = 115;
        this.parameters[1].y = 10;
        this.parameters[2].x = 225;
        this.parameters[2].y = 10;
        this.parameters[3].x = 115;
        this.parameters[3].y = 36;
        this.parameters[4].x = 225;
        this.parameters[4].y = 36;
        this.parameters[5].x = 115;
        this.parameters[5].y = 62;
        this.parameters[6].x = 10;
        this.parameters[6].y = 62;
    }

    private function drawBackground():void
    {
        graphics.clear();
        graphics.beginFill(0x2b2b2b, 1);
        graphics.lineStyle(2, 0x151515);
        graphics.drawRoundRect(0, 0, Editor.INSET_WIDTH - 20, 90, 15, 15);
        graphics.endFill();
        graphics.beginFill(0x151515, 1);
        graphics.drawRoundRect(0, 0, 20, 90, 15, 15);
        graphics.endFill();
        graphics.beginFill(0x151515, 1);
        graphics.drawRect(8, 0, 95, 90);
        graphics.endFill();
    }
}
}
