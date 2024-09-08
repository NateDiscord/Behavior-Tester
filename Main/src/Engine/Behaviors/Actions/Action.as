package Engine.Behaviors.Actions {
import flash.utils.getTimer;

public class Action {
    public var startTime:Number;
    public var elapsedTime:Number = 0;
    public var cycle:Boolean = true;

    public function Action() {
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
