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
    private var behavior:BehaviorDb;
    private var currentState:int;
    private var cycleLogic:CycleLogic;
    private var lastUpdateTime:int;

    public function GameManager(behaviorData:BehaviorDb) {
        this.behavior = behaviorData;
        this.map = new Map();
        this.addChild(this.map);

        var obj:BasicObject = new BasicObject(this.map, ObjectLibrary.idToType_[this.behavior.name_]);
        this.map.AddObj(obj);
        this.currentState = 0;

        // Initialize the CycleLogic instance
        this.cycleLogic = new CycleLogic(this.map, this.behavior, this.currentState);

        this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        var timer:Timer = new Timer(10);
        timer.addEventListener(TimerEvent.TIMER, onTimerEvent);
        timer.start();
    }

    private function onTimerEvent(event:TimerEvent):void {
        // Delegate the cooldown and shooting logic to CycleLogic
        this.cycleLogic.updateCooldownsAndShoot();
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
        this.lastUpdateTime = currentTime;
    }
}
}
