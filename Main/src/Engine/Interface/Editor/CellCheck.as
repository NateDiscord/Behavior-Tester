package Engine.Interface.Editor {
import Display.Assets.Elements.CheckBoxField;
import Display.Assets.Elements.TextInputField;
import Display.Text.SimpleText;
import Display.Util.TextUtil;

import flash.display.Sprite;

public class CellCheck extends Sprite {

    private var nameText:SimpleText;
    private var checkField:CheckBoxField;

    public function CellCheck(object:*, name:String) {
        this.nameText = new SimpleText(12, 0xaaaaaa, false);
        TextUtil.handleText(this.nameText, name, this);

        this.checkField = new CheckBoxField(false);
        this.checkField.scaleX = this.checkField.scaleY = 0.6;
        this.checkField.x = this.nameText.x + this.nameText.width + 5;
        this.checkField.y = 2;
        addChild(this.checkField);
    }
}
}
