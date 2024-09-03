package Display.Util {
import Display.Text.SimpleText;

import flash.display.Sprite;

public class TextUtil {

    public function TextUtil() {
    }

    public static function handleText(text:SimpleText, content:String, target:Sprite):void {
        text.setBold(true);
        text.filters = FilterUtil.getTextOutlineFilter();
        text.autoSize = "left";
        text.htmlText = content;
        target.addChild(text);
    }
}
}
