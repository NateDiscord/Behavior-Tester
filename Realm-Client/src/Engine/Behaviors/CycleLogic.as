package Engine.Behaviors {
import Engine.Behaviors.Modals.BehaviorDb;
import Engine.Behaviors.Modals.Shoot;
import Engine.Map;

import Modules.Projectile;
import Modules.ProjectileProperties;
import flash.utils.getTimer;

public class CycleLogic {
    private var map:Map;
    private var behavior:BehaviorDb;
    private var currentState:int;
    private var lastUpdateTime:int;

    public function CycleLogic(map:Map, behavior:BehaviorDb, currentState:int) {
        this.map = map;
        this.behavior = behavior;
        this.currentState = currentState;
        this.lastUpdateTime = 0;
    }

    public function updateCooldownsAndShoot():void {
        var projProps:ProjectileProperties = new ProjectileProperties();
        projProps.objectType_ = 0x001f;
        projProps.speed_ = 1000;
        projProps.lifetime_ = 5000;

        var currentStateActions:Array = this.behavior.statesList_[this.currentState].actions_;
        for each (var projectile:Shoot in currentStateActions) {
            // Check if the cooldown has expired
            var elapsedTime:int = getTimer() - projectile.coolDownOffset;
            if (elapsedTime >= projectile.coolDown) {
                var proj:Projectile = new Projectile(this.map, projProps, projectile.angle * (Math.PI / 180), this.lastUpdateTime);
                this.map.AddObj(proj);
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
