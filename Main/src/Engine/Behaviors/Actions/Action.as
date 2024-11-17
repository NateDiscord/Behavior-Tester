package Engine.Behaviors.Actions {
import Display.Assets.Objects.Entity;

import flash.utils.getTimer;

public class Action {
    public var startTime:Number;
    public var elapsedTime:Number = 0;
    public var cycle:Boolean = true;
    public var entity:Entity;

    public function Action(en:Entity) {
        this.entity = en;
        this.startTime = getTimer();
    }

    public function resetTime() : void {
        this.startTime = getTimer();
        this.elapsedTime = 0;
        this.cycle = true;
    }

    public function update() : void {
    }

    public function updateTime() : void {
        this.elapsedTime = getTimer() - this.startTime;
    }
}
}
