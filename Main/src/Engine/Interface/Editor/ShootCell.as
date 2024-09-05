package Engine.Interface.Editor {
import Display.Text.SimpleText;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.Shoot;

import flash.display.Sprite;


public class ShootCell extends Sprite {

    private var action:Shoot;
    public var actionText:SimpleText;
    private var parameters:Vector.<CellParameter>;

    public static var PARAMETERS:Array;
    public static var DISPLAY_NAMES:Array = ["Angle", "Proj. Index", "Cooldown", "Cooldown Offset"];

    public function ShootCell(action:Shoot) {
        this.action = action;
        if (!this.action is Shoot)
            return;

        drawBackground();
        addHeader();
        addParams();
    }

    private function addHeader():void
    {
        this.actionText = new SimpleText(14, 0xaaaaaa, false);
        this.actionText.x = this.actionText.y = 6;
        TextUtil.handleText(this.actionText, "new <font color=\"#ffffff\">Shoot</font>:", this);
    }

    private function addParams():void
    {
        PARAMETERS = [this.action.angle, this.action.projectileIndex,  this.action.coolDown, this.action.msOffset];
        this.parameters = new Vector.<CellParameter>();
        for (var i:int = 0; i < PARAMETERS.length; i++)
        {
            this.parameters[i] = new CellParameter(PARAMETERS[i], DISPLAY_NAMES[i]);
            this.parameters[i].x = 100 + (int(i % 2) * 110);
            this.parameters[i].y = 7 + (25 * int(i / 2));
            addChild(this.parameters[i]);
            this.parameters.push(this.parameters[i]);
        }
    }

    private function drawBackground():void
    {
        graphics.clear();
        graphics.beginFill(0x2b2b2b, 1);
        graphics.lineStyle(2, 0x151515);
        graphics.drawRoundRect(0, 0, EditorPanel.INSET_WIDTH - 20, 60, 15, 15);
        graphics.endFill();
    }
}
}
