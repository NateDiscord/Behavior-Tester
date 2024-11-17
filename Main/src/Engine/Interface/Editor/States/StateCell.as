package Engine.Interface.Editor.States {
import Display.Text.SimpleText;
import Display.Util.ColorUtil;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.Behavior;
import Engine.Behaviors.Modals.BehaviorDb;

import Engine.Behaviors.Modals.Shoot;
import Engine.Behaviors.Modals.Wander;
import Engine.File.Parameters;
import Engine.Interface.Editor;
import Engine.Interface.Editor.Behaviors.BehaviorCell;
import Engine.Interface.Editor.Behaviors.ShootCell;
import Engine.Interface.Editor.Behaviors.WanderCell;
import Engine.Interface.Editor.NewCell;

import flash.display.Sprite;
import flash.events.MouseEvent;

public class StateCell extends Sprite {

    private var indexText:SimpleText;
    private var nameText:SimpleText;
    private var background:Sprite;

    public var index:int;
    public var editor:Editor;
    private var expanded:Boolean;

    public function StateCell(index:int, host:Editor) {
        this.index = index;
        this.editor = host;
        this.expanded = false;
        addAssets();
    }

    private function addAssets():void {
        this.background = new Sprite();
        this.background.addEventListener(MouseEvent.CLICK, onClick);
        addChild(this.background);

        this.indexText = new SimpleText(12, 0xaaaaaa, false);
        this.indexText.x = this.indexText.y = 4;
        TextUtil.handleText(this.indexText, (index + 1) + ".", this);

        var behav:BehaviorDb = Parameters.data_["targetBehavior"];
        var name:String = behav.statesList_[index].id_;
        this.nameText = new SimpleText(16, 0xffffff, false);
        this.nameText.x = 20;
        this.nameText.y = 4;
        TextUtil.handleText(this.nameText, name, this);

        this.background.graphics.clear();
        this.background.graphics.beginFill(ColorUtil.STATE_CELL_COLOR, 0.9);
        this.background.graphics.drawRect(0, 0, Editor.INSET_WIDTH - 20, 30);
        this.background.graphics.endFill();
    }

    private function onClick(event:MouseEvent):void {
        removeExistingActionCells();
        if (!this.expanded)
            createActionCells();
        else
           this.expanded = false;
        this.editor.rePosition();
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
        var behav:BehaviorDb = Parameters.data_["targetBehavior"];
        var state:Object = behav.statesList_[this.index];
        var actions:Array = state.actions_;

        var yPos:int = 30;
        for (var i:int = 0; i < actions.length + 1; i++) {
            var action:Object = actions[i];
            var cell:*;
            switch (true) {
                case action is Shoot:
                    var sh:Shoot = action as Shoot;
                    cell = new ShootCell(i, this, sh);
                    break;
                case action is Wander:
                    var wa:Wander = action as Wander;
                    cell = new WanderCell(i, this, wa);
                    break;
                default:
                    cell = new NewCell(i, this);
                    break;
            }

            cell.y = yPos;
            yPos += cell.height;
            addChild(cell);
        }
        this.expanded = true;
    }
}
}
