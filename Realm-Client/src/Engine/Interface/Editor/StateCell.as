package Engine.Interface.Editor {
import Display.Text.SimpleText;
import Display.Util.TextUtil;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.display.DisplayObjectContainer;

public class StateCell extends Sprite {
    private var nameText:SimpleText;
    private var background:Sprite;

    private var index:int;
    private var expanded:Boolean;

    private var host:EditorPanel;

    public function StateCell(index:int, host:EditorPanel) {
        this.index = index;
        this.host = host;
        this.expanded = false;

        this.background = new Sprite();
        addChild(this.background);

        var name:String = Main.CURRENT_BEHAVIOR.statesList_[index].id_;
        this.nameText = new SimpleText(14, 0xffffff, false);
        this.nameText.x = 5;
        this.nameText.y = 5;
        TextUtil.handleText(this.nameText, name, this);

        this.background.graphics.clear();
        this.background.graphics.beginFill(0x101010, 0.5);
        this.background.graphics.drawRoundRect(0, 0, 230, 30, 10, 10);
        this.background.graphics.endFill();

        addEventListener(MouseEvent.CLICK, onClick);
    }

    private function onClick(event:MouseEvent):void {
        removeExistingActionCells();
        if (!this.expanded)
            createActionCells();
        else
           this.expanded = false;
        this.host.rePosition();
    }

    private function removeExistingActionCells():void {
        // Remove all children that are of type ActionCell
        for (var i:int = numChildren - 1; i >= 0; i--) {
            var child:Object = getChildAt(i);
            if (child is ActionCell) {
                removeChildAt(i);
            }
        }
    }

    private function createActionCells():void {
        var state:Object = Main.CURRENT_BEHAVIOR.statesList_[this.index];
        var actions:Array = state.actions_; // Assuming actions_ is an array of action objects

        var yPos:int = 40; // Starting Y position for action cells
        for (var i:int = 0; i < actions.length; i++) {
            var action:Object = actions[i];
            var actionCell:ActionCell = new ActionCell(action, i);
            actionCell.y = yPos;

            addChild(actionCell);

            yPos += actionCell.height + 10; // Move position down for the next action cell
        }
        this.expanded = true;
    }
}
}
