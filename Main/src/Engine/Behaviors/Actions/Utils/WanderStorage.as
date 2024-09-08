package Engine.Behaviors.Actions.Utils {
import flash.geom.Point;

public class WanderStorage {
    public var direction:Point;
    public var remainingDistance:Number;

    public function WanderStorage() {
        direction = new Point();
        remainingDistance = 0;
    }
}
}
