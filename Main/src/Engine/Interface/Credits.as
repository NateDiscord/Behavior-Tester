package Engine.Interface {
import Display.Text.SimpleText;
import Display.Util.FilterUtil;

import flash.display.Sprite;

public class Credits extends Sprite {

    public static const TITLE:String = "Behavior Editor v1.0";
    public static const DESC:String = "by: Heffy & runes.";

    public function Credits() {
        var tt:SimpleText = new SimpleText(14, 0xffffff, false);
        this.handleText(tt, TITLE);

        var dt:SimpleText = new SimpleText(12, 0xaaaaaa, false);
        this.handleText(dt, DESC);

        dt.x = tt.width / 2 - dt.width / 2;
        dt.y = tt.height - 3;
    }

    private function handleText(text:SimpleText, content:String):void {
        text.setBold(true);
        text.filters = FilterUtil.getTextOutlineFilter();
        text.autoSize = "left";
        text.htmlText = content;
        addChild(text);
    }
}
}
