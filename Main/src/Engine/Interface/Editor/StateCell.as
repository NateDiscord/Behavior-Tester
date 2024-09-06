package Engine.Interface.Editor {
import Display.Text.SimpleText;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.Shoot;

import flash.display.Sprite;
import flash.events.MouseEvent;

public class StateCell extends Sprite {

    private var indexText:SimpleText;
    private var nameText:SimpleText;
    private var background:Sprite;

    public var index:int;
    private var expanded:Boolean;

    private var host:EditorPanel;

    public function StateCell(index:int, host:EditorPanel) {
        this.index = index;
        this.host = host;
        this.expanded = false;

        this.background = new Sprite();
        this.background.addEventListener(MouseEvent.CLICK, onClick);
        addChild(this.background);

        this.indexText = new SimpleText(12, 0xaaaaaa, false);
        this.indexText.x = this.indexText.y = 4;
        TextUtil.handleText(this.indexText, (index + 1) + ".", this);

        var name:String = Main.CURRENT_BEHAVIOR.statesList_[index].id_;
        this.nameText = new SimpleText(18, 0xffffff, false);
        this.nameText.x = 20;
        this.nameText.y = 9;
        TextUtil.handleText(this.nameText, name, this);

        this.background.graphics.clear();
        this.background.graphics.lineStyle(2, 0x101010);
        this.background.graphics.beginFill(0x151515, 1);
        this.background.graphics.drawRoundRect(0, 0, EditorPanel.INSET_WIDTH - 20, 40, 15, 15);
        this.background.graphics.endFill();
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
        for (var i:int = numChildren - 1; i >= 0; i--) {
            var child:Object = getChildAt(i);
            if (child is BehaviorCell || child is ShootCell) {
                removeChildAt(i);
            }
        }
    }

    private function createActionCells():void {
        var state:Object = Main.CURRENT_BEHAVIOR.statesList_[this.index];
        var actions:Array = state.actions_;

        var yPos:int = 45;
        for (var i:int = 0; i < actions.length; i++) {
            var action:Object = actions[i];
            var cell:*;
            if (action is Shoot)
                cell = new ShootCell(i, this);
            else
                cell = new BehaviorCell(i, this);
            cell.y = yPos;
            addChild(cell);

            yPos += cell.height + 5;
        }
        this.expanded = true;
    }
}
}
