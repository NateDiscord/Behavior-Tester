package Engine.Interface.Editor {
import Display.Assets.Elements.TextInputField;
import Display.Text.SimpleText;
import Display.Util.TextUtil;

import flash.display.Sprite;

public class CellParameter extends Sprite {

    private var nameText:SimpleText;
    private var inputField:TextInputField;

    public function CellParameter(object:*, name:String) {
        this.nameText = new SimpleText(12, 0xaaaaaa, false);
        this.nameText.y = 2;
        TextUtil.handleText(this.nameText, name, this);

        this.inputField = new TextInputField("", false, "", 40, 20, 12);
        this.inputField.x = this.nameText.x + this.nameText.width + 5;
        this.inputField.setText(object.toString());
        addChild(this.inputField);
    }
}
}
