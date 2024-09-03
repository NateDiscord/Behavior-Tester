package Engine.Interface.Editor {
import Display.Text.SimpleText;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.Shoot;

import flash.display.Sprite;

public class ActionCell extends Sprite {
    private var action:Object;

    private var actionText:SimpleText;
    private var subText:SimpleText;

    public function ActionCell(action:Object, index:int) {
        this.action = action;
        graphics.beginFill(0x303030, 0.7);
        graphics.drawRoundRect(0, 0, 230, 30, 10, 10);
        graphics.endFill();

        if (!this.action is Shoot)
            return;
        this.actionText = new SimpleText(14, 0xffffff, false);
        this.actionText.x = this.actionText.y = 6;
        TextUtil.handleText(this.actionText, "Shoot:", this);

        var shoot:Shoot = this.action as Shoot;
        var text:String = "<font color=\"#ffffff\">angle:</font> "
                + shoot.angle + ", <font color=\"#ffffff\">index:</font> "
                + shoot.projectileIndex + ", <font color=\"#ffffff\">cd:</font> "
                + shoot.coolDown + " ms, \n<font color=\"#ffffff\">offset:</font> "
                + shoot.coolDownOffset + " ms.";
        this.subText = new SimpleText(11, 0xaaaaaa, false);
        this.subText.x = this.actionText.x + this.actionText.width + 3;
        this.subText.y = 2;
        TextUtil.handleText(this.subText, text, this);
    }
}
}
