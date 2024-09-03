package Engine.Behaviors {
import Display.Assets.Objects.Entity;
import Display.Control.ObjectLibrary;

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
    private var lastUpdateTime:int;

    public function CycleLogic(map:Map, behavior:BehaviorDb, currentState:int) {
        this.map = map;
        this.behavior = behavior;
        this.host = this.map.FindEntity(ObjectLibrary.idToType_[behavior.name_]);
        this.currentState = currentState;
        this.lastUpdateTime = 0;
    }

    public function updateCooldownsAndShoot():void {
        var currentStateActions:Array = this.behavior.statesList_[this.currentState].actions_;
        for each (var projectile:Shoot in currentStateActions) {
            var elapsedTime:int = getTimer() - projectile.coolDownOffset;
            if (elapsedTime >= projectile.coolDown) {
                var proj:Projectile = new Projectile(this.map, projProps, projectile.angle * (Math.PI / 180), this.lastUpdateTime);
                this.map.addObj(proj);
                var proj:Projectile = new Projectile(this.map, this.host, this.host.projectiles_[projectile.projectileIndex], projectile.angle * (Math.PI / 180), this.lastUpdateTime);
                this.map.addChild(proj);
                // Update the last time this action was performed
                projectile.coolDownOffset = getTimer();
            }
        }
    }

    public function setLastUpdateTime(time:int):void {
        this.lastUpdateTime = time;
    }
}
}
