package Engine.Behaviors {
import Display.Assets.Objects.Entity;
import Display.Control.ObjectLibrary;

import Engine.Behaviors.Actions.Action;
import Engine.Behaviors.Actions.ShootAction;

import Engine.Behaviors.Modals.BehaviorDb;
import Engine.Behaviors.Modals.Shoot;
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
        for each (var shootAction:Shoot in currentStateActions)
        {
            this.actionListGo.push(new ShootAction(this.host, shootAction));
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
