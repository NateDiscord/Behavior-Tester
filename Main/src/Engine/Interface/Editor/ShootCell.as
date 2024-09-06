package Engine.Interface.Editor {
import Display.Text.SimpleText;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.Behavior;

import Engine.Behaviors.Modals.Shoot;

import flash.display.Sprite;


public class ShootCell extends BehaviorCell {

    private var action:Shoot;
    public var actionText:SimpleText;
    private var parameters:Vector.<Sprite>;

    public var CHECK:Array;

    public function ShootCell(index:int, host:StateCell) {
        super(index, host);
        var action:Shoot = Main.CURRENT_BEHAVIOR.statesList_[host.index].actions_[index];
        if (!action is Shoot)
            return;

        this.action = action as Shoot;

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
        PARAMETERS = ["shots", "arc", "fixedAngle", "projectileIndex", "coolDown", "coolDownOffset", "predictive"];
        CHECK = [false, false, false, false, false, false, true];
        this.parameters = new Vector.<Sprite>();
        for (var i:int = 0; i < PARAMETERS.length; i++)
        {
            if (CHECK[i])
                this.parameters[i] = new CellCheck(i, this);
            else
                this.parameters[i] = new CellParameter(this, i);
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
