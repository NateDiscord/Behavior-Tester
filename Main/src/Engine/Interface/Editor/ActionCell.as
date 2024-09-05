package Engine.Interface.Editor {
import Display.Text.SimpleText;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.Shoot;

import flash.display.Sprite;

public class ActionCell extends Sprite {
    private var action:Object;

    public var actionText:SimpleText;

    public function ActionCell(action:Object) {
        this.action = action;
        graphics.beginFill(0x2b2b2b, 1);
        graphics.lineStyle(2, 0x050505);
        graphics.drawRoundRect(0, 0, EditorPanel.INSET_WIDTH - 20, 40, 15, 15);
        graphics.endFill();

        if (!this.action is Shoot)
            return;

        this.actionText = new SimpleText(14, 0xaaaaaa, false);
    }
}
}
