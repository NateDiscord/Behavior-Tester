package Engine.Behaviors {
import Display.Assets.Objects.Entity;
import Display.Control.ObjectLibrary;

import Engine.Behaviors.Actions.Action;
import Engine.Behaviors.Actions.ShootAction;
import Engine.Behaviors.Actions.WanderAction;

import Engine.Behaviors.Modals.BehaviorDb;
import Engine.Behaviors.Modals.Shoot;
import Engine.Behaviors.Modals.Wander;
import Engine.Map;

import Modules.Projectile;
import flash.utils.getTimer;

public class CycleLogic {
    private var map:Map;
    private var behavior:BehaviorDb;
    private var host:Entity;
    private var currentState:int;
    private var lastUpdateTime:Number;
    private var actionListGo:Array;

    public function CycleLogic(map:Map, behavior:BehaviorDb, currentState:int) {
        this.map = map;
        this.behavior = behavior;
        this.host = this.map.findEntity(ObjectLibrary.idToType_[behavior.name_]);
        this.currentState = currentState;
        this.lastUpdateTime = 0;
        this.actionListGo = [];
        var currentStateActions:Array = this.behavior.statesList_[this.currentState].actions_;
        for each (var action:Object in currentStateActions)
        {
            var actionType:String = action.action;
            if (actionType)
            {
                var actionClass:Class = ActionLibrary.ACTION_MAP[actionType];
                var actionInstance:Object = new actionClass(this.host, action);
                this.actionListGo.push(actionInstance);
            }
        }
    }

    public function update(time:Number):void {
        for each (var action:Action in this.actionListGo) {
            action.update();
        }
        this.lastUpdateTime = time;
    }
}
}
