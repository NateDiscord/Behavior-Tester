package Engine.Interface.Editor {

import Display.Assets.Elements.CheckBoxField;
import Display.Text.SimpleText;
import Display.Util.TextUtil;

import Engine.Interface.Editor.Behaviors.BehaviorCell;

import flash.display.Sprite;
import flash.events.Event;

public class CellCheck extends Sprite {

    public var index:int;
    public var host:BehaviorCell;

    private var nameText:SimpleText;
    private var checkField:CheckBoxField;

    private var names:Array;

    public function CellCheck(index:int, host:BehaviorCell) {
        this.host = host;
        this.index = index;
        this.names = this.host.behavior.toString;

        addAssets();
    }

    private function addAssets():void
    {
        var name:String = this.names[this.index];
        this.nameText = new SimpleText(12, 0xaaaaaa, false);
        TextUtil.handleText(this.nameText, name, this);

        this.checkField = new CheckBoxField(false);
        this.checkField.scaleX = this.checkField.scaleY = 0.6;
        this.checkField.x = this.nameText.x + this.nameText.width + 5;
        this.checkField.y = 2;
        this.checkField.addEventListener(Event.CHANGE, onCheckFieldChange);
        addChild(this.checkField);
    }

    private function onCheckFieldChange(event:Event):void {
    }
}
}
