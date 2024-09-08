package Engine.Behaviors.Modals {
public class Shoot extends Behavior {

    public var shots:int = 0;
    public var angle:Number = 0;
    public var projectileIndex:int = 0;
    public var coolDown:Number = 0;
    public var msOffset:Number = 0;
    public var coolDownOffset:Number = 0;
    public var fixedAngle:Number = 0;
    public var predictive:int = 0;

    public function Shoot()
    {
        super();
        action = "Shoot";
        toString = ["shots", "angle", "projectileIndex", "coolDown", "coolDownOffset", "fixedAngle", "predictive"];
    }
}
}
