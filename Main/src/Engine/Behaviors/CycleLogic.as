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
    private var lastUpdateTime:Number;

    public function CycleLogic(map:Map, behavior:BehaviorDb, currentState:int) {
        this.map = map;
        this.behavior = behavior;
        this.host = this.map.findEntity(ObjectLibrary.idToType_[behavior.name_]);
        this.currentState = currentState;
        this.lastUpdateTime = 0;
    }

    public function updateCooldownsAndShoot(deltaTime:Number):void {
        var currentStateActions:Array = this.behavior.statesList_[this.currentState].actions_;
        var j:int = 0;

        for each (var shootAction:Shoot in currentStateActions) {
            var batch:Vector.<Projectile>;
            shootAction.coolDownOffset += deltaTime *  1000;
            if (shootAction.coolDownOffset >= shootAction.coolDown) {
                batch = new Vector.<Projectile>();
                for (var i:int = 0; i < shootAction.shots; i++) {
                    var angle:Number = shootAction.fixedAngle + (shootAction.arc * i);
                    var projectile:Projectile = new Projectile(
                            this.map,
                            this.host,
                            this.host.projectiles_[shootAction.projectileIndex],
                            angle * (Math.PI / 180),
                            this.lastUpdateTime
                    );
                    batch.push(projectile);
                    this.map.addObj(projectile);
                }
                shootAction.coolDownOffset = 0;
            }
            batch = null;
            j++;
        }
    }

    public function setLastUpdateTime(time:int):void {
        this.lastUpdateTime = time;
    }
}
}
