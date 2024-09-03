package Engine.Interface.Editor {
import Display.Text.SimpleText;
import flash.display.Sprite;

public class ActionCell extends Sprite {
    private var actionTexts:Vector.<SimpleText>;

    public function ActionCell(stateIndex:int) {
        // Initialize the background of the cell
        this.graphics.beginFill(0x202020, 0.5);
        this.graphics.drawRoundRect(0, 0, 200, 200, 8, 8);
        this.graphics.endFill();

        // Retrieve the actions from the state
        var state:Object = Main.CURRENT_BEHAVIOR.statesList_[stateIndex];
        var actions:Array = state.actions_; // Assuming actions_ is an array of action objects

        this.actionTexts = new Vector.<SimpleText>();

        // Display each action as SimpleText
        var yPos:int = 10;
        for each (var action:Object in actions) {
            var actionText:SimpleText = new SimpleText(12, 0xffffff, false);
            var actionDetails:String = formatActionDetails(action);
            actionText.text = actionDetails;
            actionText.x = 10;
            actionText.y = yPos;

            this.addChild(actionText);
            this.actionTexts.push(actionText);

            yPos += actionText.height + 5; // Move position down for the next action
        }
    }

    private function formatActionDetails(action:Object):String {
        // Format the action details as a string
        // Example format: "ActionType: <type>, ProjectileIndex: <index>, Angle: <angle>"
        var details:String = "ActionType: " + action.type;
        if (action.projectileIndex !== undefined) {
            details += ", ProjectileIndex: " + action.projectileIndex;
        }
        if (action.angle !== undefined) {
            details += ", Angle: " + action.angle;
        }
        if (action.coolDown !== undefined) {
            details += ", CoolDown: " + action.coolDown;
        }
        if (action.coolDownOffset !== undefined) {
            details += ", CoolDownOffset: " + action.coolDownOffset;
        }
        return details;
    }
}
}
