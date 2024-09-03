package Engine.Interface.Editor {
import Display.Text.SimpleText;
import Display.Util.FilterUtil;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.BehaviorDb;

import flash.display.Sprite;
import flash.events.VideoEvent;

public class StateCell extends Sprite {

    private var nameText:SimpleText;
    private var actionTexts:Vector.<SimpleText>;

    private var background:Sprite;

    public function StateCell(index:int) {
        this.background = new Sprite();
        addChild(this.background);

        var name:String = Main.CURRENT_BEHAVIOR.statesList_[index].id_;
        this.nameText = new SimpleText(14, 0xffffff, false);
        this.nameText.x = 5;
        this.nameText.y = 5;
        TextUtil.handleText(this.nameText, name, this);

        this.background.graphics.clear();
        this.background.graphics.beginFill(0x101010, 0.5);
        this.background.graphics.drawRoundRect(0, 0, 180, 30, 10, 10);
        this.background.graphics.endFill();
    }
}
}
