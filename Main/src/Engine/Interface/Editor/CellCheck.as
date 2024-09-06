package Engine.Interface.Editor {
import Display.Assets.Elements.CheckBoxField;
import Display.Text.SimpleText;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.Behavior;

import Engine.Behaviors.Modals.Shoot;

import Engine.Interface.Editor.ActionCell;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextSnapshot;

public class CellCheck extends Sprite {

    public var host:BehaviorCell;
    public var index:int;

    private var nameText:SimpleText;
    private var checkField:CheckBoxField;

    public function CellCheck(index:int, host:BehaviorCell) {
        this.host = host;
        this.index = index;
        if (host is ShootCell)
            this.host = host as ShootCell;

        this.nameText = new SimpleText(12, 0xaaaaaa, false);
        TextUtil.handleText(this.nameText, name, this);

        this.checkField = new CheckBoxField(false);
        this.checkField.scaleX = this.checkField.scaleY = 0.6;
        this.checkField.x = this.nameText.x + this.nameText.width + 5;
        this.checkField.y = 2;
        this.checkField.addEventListener(Event.CHANGE, onCheckFieldChange);
        addChild(this.checkField);
    }

    private function setType():void
    {
        var type:String = this.host.PARAMETERS[this.index];
        switch (type)
        {

        }
    }

    private function onCheckFieldChange(event:Event):void {
        this.action.predictive = this.checkField.isChecked();
    }
}
}
