package Engine.Interface.Editor {

import Display.Assets.Elements.TextInputField;
import Display.Text.SimpleText;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.Behavior;
import Engine.Behaviors.Modals.BehaviorDb;

import Engine.Behaviors.Modals.Shoot;
import Engine.Behaviors.Modals.Wander;
import Engine.File.Parameters;
import Engine.Interface.Editor.Behaviors.BehaviorCell;
import Engine.Interface.Editor.Behaviors.ShootCell;
import Engine.Interface.Editor.Behaviors.WanderCell;

import flash.display.Sprite;
import flash.events.Event;

public class CellParameter extends Sprite {

    public var behaviorCell:BehaviorCell;
    public var index:int;

    private var nameText:SimpleText;
    private var inputField:TextInputField;

    private var names:Array;

    public function CellParameter(host:BehaviorCell, index:int) {
        this.behaviorCell = host;
        this.index = index;
        this.names = this.behaviorCell.behavior.toString;
        addAssets();
    }

    private function addAssets():void
    {
        var name:String = this.names[this.index];
        this.nameText = new SimpleText(12, 0xaaaaaa, false);
        this.nameText.y = 2;
        TextUtil.handleText(this.nameText, name + ":", this);

        this.inputField = new TextInputField("", false, "", 40, 20, 12);
        this.inputField.x = this.nameText.x + this.nameText.width + 5;
        this.inputField.setText(behaviorCell.PARAMETERS[index]);
        this.inputField.addEventListener(Event.CHANGE, onInputFieldChange);
        addChild(this.inputField);
    }

    private function onInputFieldChange(event:Event):void {
        var value:Number = Number(this.inputField.text());
        if (!isNaN(value)) {
            handle(this.names[this.index], value);
        }
    }

    private function handle(type:String, value:int):void
    {
        var behav:BehaviorDb = Parameters.data_["targetBehavior"];
        if (this.behaviorCell is ShootCell)
            {
                var shoot:Shoot = behav.statesList_[this.behaviorCell.stateCell.index].actions_[this.behaviorCell.index];
                if (shoot == null)
                    return;
                switch (type)
                {
                    case "shots": shoot.shots = value; break;
                    case "angle": shoot.angle = value; break;
                    case "fixedAngle": shoot.fixedAngle = value; break;
                    case "predictive": shoot.predictive = value; break;
                    case "projectileIndex": shoot.projectileIndex = value; break;
                    case "coolDown": shoot.coolDown = value; break;
                    case "coolDownOffset": shoot.coolDownOffset = value; break;
                }
                behav.statesList_[this.behaviorCell.stateCell.index].actions_[this.behaviorCell.index] = shoot;
        }
        if (this.behaviorCell is WanderCell)
        {
            var wander:Wander = behav.statesList_[this.behaviorCell.stateCell.index].actions_[this.behaviorCell.index];
            if (wander == null)
                return;
            wander.speed = value;
            behav.statesList_[this.behaviorCell.stateCell.index].actions_[this.behaviorCell.index] = wander;
        }
    }
}
}
