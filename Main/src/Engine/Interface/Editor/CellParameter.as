package Engine.Interface.Editor {
import Display.Assets.Elements.TextInputField;
import Display.Text.SimpleText;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.Behavior;
import Engine.File.Parameters;

import flash.display.Sprite;
import flash.events.Event;

public class CellParameter extends Sprite {

    private var host:BehaviorCell;
    private var index:int;

    private var nameText:SimpleText;
    private var inputField:TextInputField;

    public function CellParameter(host:BehaviorCell, index:int) {
        this.host = host;
        this.index = index;

        this.nameText = new SimpleText(12, 0xaaaaaa, false);
        this.nameText.y = 2;
        TextUtil.handleText(this.nameText, name, this);

        this.inputField = new TextInputField("", false, "", 40, 20, 12);
        this.inputField.x = this.nameText.x + this.nameText.width + 5;
        this.inputField.setText(host.PARAMETERS[index]);
        this.inputField.addEventListener(Event.CHANGE, onInputFieldChange);
        addChild(this.inputField);
    }

    private function onInputFieldChange(event:Event):void {
        var value:Number = Number(this.inputField.text());
        if (!isNaN(value)) {
            Main.CURRENT_BEHAVIOR.statesList_[host.index].actions_[index];
        }
    }
}
}
