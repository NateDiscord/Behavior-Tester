package Engine {
import Display.Assets.Objects.BasicObject;
import Display.Control.ObjectLibrary;

import Engine.Behaviors.CycleLogic;

import Engine.Behaviors.Modals.BehaviorDb;
import Engine.Behaviors.Modals.Shoot;
import Engine.Behaviors.Modals.State;

import Modules.Projectile;

import Modules.ProjectileProperties;

import flash.display.Sprite;

import flash.events.Event;

import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.utils.getTimer;

public class GameManager extends Sprite {
    private var map:Map;
    private var camera:Camera;
    private var behavior:BehaviorDb;
    private var cycleLogic:CycleLogic;
    private var lastUpdateTime:int;

    public function GameManager(behaviorData:BehaviorDb) {
        this.behavior = behaviorData;
        this.map = new Map();
        this.camera = new Camera(this.map, 800, 600);
        addChild(this.camera);

        var obj:BasicObject = new BasicObject(this.map, ObjectLibrary.idToType_[this.behavior.name_]);
        this.map.AddObj(obj);

        // Initialize the CycleLogic instance
        this.cycleLogic = new CycleLogic(this.map, this.behavior, 0);

        this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private function onEnterFrame(event:Event):void {
        var currentTime:int = getTimer();
        for (var i:int = this.map.numChildren - 1; i >= 0; i--) {
            var child:BasicObject = this.map.getChildAt(i) as BasicObject;
            if (child) {
                child.update(currentTime);
            }
        }
        // Update the last update time in CycleLogic
        this.cycleLogic.setLastUpdateTime(currentTime);
        this.cycleLogic.updateCooldownsAndShoot();
        this.lastUpdateTime = currentTime;
    }
}
}
