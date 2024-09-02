package Engine {
import Display.Assets.Objects.BasicObject;

import Modules.Projectile;
import Modules.ProjectileProperties;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.utils.getTimer;

public class Map extends Sprite {
    private var timer:Timer = new Timer(500);
    private var lastUpdateTime:int;
    private var angle:int = 0;

    public function Map() {
        addEventListener(Event.ENTER_FRAME, onEnterFrame);
        var obj:BasicObject = new BasicObject(this, 0x0e1d);
        this.AddObj(obj);
        this.timer.addEventListener(TimerEvent.TIMER, onTimerEvent);
        this.timer.start();
    }

    private function onEnterFrame(event:Event):void {
        var currentTime:int = getTimer();
        for (var i:int = numChildren - 1; i >= 0; i--) {
            var child:BasicObject = getChildAt(i) as BasicObject;
            if (child) {
                child.update(currentTime);
            }
        }
        lastUpdateTime = currentTime;
    }

    private function onTimerEvent(event:TimerEvent):void {
        var projProps:ProjectileProperties = new ProjectileProperties();
        projProps.objectType_ = 0x001f;
        projProps.speed_ = 1000;
        projProps.lifetime_ = 5000;
        var proj:Projectile = new Projectile(this, projProps, (angle) * (Math.PI / 180), this.lastUpdateTime);
        var proj2:Projectile = new Projectile(this, projProps, (angle+90) * (Math.PI / 180), this.lastUpdateTime);
        var proj3:Projectile = new Projectile(this, projProps, (angle+180) * (Math.PI / 180), this.lastUpdateTime);
        var proj4:Projectile = new Projectile(this, projProps, (angle+270) * (Math.PI / 180), this.lastUpdateTime);
        this.AddObj(proj);
        this.AddObj(proj2);
        this.AddObj(proj3);
        this.AddObj(proj4);
        angle+= 5;
    }

    public function AddObj(obj:BasicObject) : void {
        this.addChild(obj);
    }

    public  function RemoveObj(obj:BasicObject) : void {
        this.removeChild(obj);
    }
}
}
