package Engine.Interface {
import Display.Text.SimpleText;
import Display.Util.FilterUtil;

import flash.display.SimpleButton;
import flash.display.Sprite;

public class Interface extends Sprite {

    private var headerText:SimpleText;
    private var descText:SimpleText;

    public function Interface() {
        this.headerText = new SimpleText(18, 0xffffff, false);
        this.handleText(this.headerText, "Behavior Editor");

        this.descText = new SimpleText(12, 0xcccccc, false);
        this.descText.y = this.headerText.y + this.headerText.height - 3;
        this.handleText(this.descText, "by Heffy & runes.");
    }

    public function handleText(obj:SimpleText, text:String):void
    {
        obj.setBold(true);
        obj.filters = FilterUtil.getStandardDropShadowFilter();
        obj.autoSize = "left";
        obj.htmlText = text;
        addChild(obj)
    }
}
}
