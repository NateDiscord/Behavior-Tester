package Engine.Interface.Editor {
import Display.Text.SimpleText;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.Shoot;

import flash.display.Sprite;


public class ShootCell extends Sprite {

    private var action:Shoot;
    public var actionText:SimpleText;
    private var parameters:Vector.<Sprite>;

    public static var PARAMETERS:Array;
    public static var DISPLAY_NAMES:Array = ["Shots", "Arc Gap", "Angle", "Proj. Index", "Cooldown", "Cooldown Offset", "Predictive"];
    public static var CHECK:Array = [false, false, false, false, false, false, true];

    public function ShootCell(action:Shoot) {
        this.action = action;
        if (!this.action is Shoot)
            return;

        drawBackground();
        addHeader();
        addParams();
        positionParams();
    }

    private function addHeader():void
    {
        this.actionText = new SimpleText(14, 0xaaaaaa, false);
        this.actionText.x = this.actionText.y = 6;
        TextUtil.handleText(this.actionText, "new <font color=\"#ffffff\">Shoot</font>:", this);
    }

    private function addParams():void
    {
        PARAMETERS = [this.action.shots, this.action.angle, this.action.fixedAngle, this.action.projectileIndex,  this.action.coolDown, this.action.msOffset, this.action.predictive];
        this.parameters = new Vector.<Sprite>();
        for (var i:int = 0; i < PARAMETERS.length; i++)
        {
            if (CHECK[i])
                this.parameters[i] = new CellCheck(PARAMETERS[i], DISPLAY_NAMES[i]);
            else
                this.parameters[i] = new CellParameter(PARAMETERS[i], DISPLAY_NAMES[i]);
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
        graphics.drawRoundRect(0, 0, EditorPanel.INSET_WIDTH - 20, 90, 15, 15);
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
