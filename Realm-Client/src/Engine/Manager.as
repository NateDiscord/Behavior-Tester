package Engine {
import Display.Assets.Objects.BasicObject;
import Display.Assets.Objects.Entity;
import Display.Control.ObjectLibrary;

import Engine.Behaviors.CycleLogic;

import Engine.Behaviors.Modals.BehaviorDb;
import Engine.Behaviors.Modals.Shoot;
import Engine.Behaviors.Modals.State;
import Engine.Interface.Interface;

import Modules.Projectile;

import Modules.ProjectileProperties;

import flash.display.Sprite;

import flash.events.Event;

import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.utils.getTimer;

public class Manager extends Sprite {

    private var map:Map;
    public var camera:Camera;
    public var gui:Interface;

    private var camera:Camera;
    private var behavior:BehaviorDb;
    private var cycleLogic:CycleLogic;
    private var lastUpdateTime:int;

    public function Manager(behaviorData:BehaviorDb) {
        this.behavior = behaviorData;

        this.map = new Map();
        this.camera = new Camera(this.map);
        addChild(this.camera);

        this.gui = new Interface();
        addChild(this.gui);

        /* debug enemy. */
        var obj:BasicObject = new BasicObject(this.map, ObjectLibrary.idToType_[this.behavior.name_]);
        this.map.addObj(obj);
        this.camera = new Camera(this.map, 800, 600);
        addChild(this.camera);

        var obj:Entity = new Entity(this.map, ObjectLibrary.idToType_[this.behavior.name_]);
        obj.x = 400;
        obj.y = 300;
        this.map.addChild(obj);

        /* initialize CycleLogic. */
        this.cycleLogic = new CycleLogic(this.map, this.behavior, 0);
        addEventListener("enterFrame", onEnterFrame);
        Main.STAGE.addEventListener("resize", onResize);
    }

    private function onResize(e:Event):void
    {
        Main.windowWidth = stage.stageWidth;
        Main.windowHeight = stage.stageHeight;
        this.camera.adjustPosition();
    }

    private function onEnterFrame(event:Event):void {
        var currentTime:int = getTimer();
        for (var i:int = this.map.numChildren - 1; i >= 0; i--) {
            var child:BasicObject = this.map.getChildAt(i) as BasicObject;
            if (child)
                child.update(currentTime);
        }
	
        this.cycleLogic.setLastUpdateTime(currentTime);
        this.cycleLogic.updateCooldownsAndShoot();
        this.lastUpdateTime = currentTime;
    }
}
}
