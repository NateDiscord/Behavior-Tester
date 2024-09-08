package Engine.Behaviors.Modals {
public class Wander extends Behavior{

    public var speed:Number = 0;

    public function Wander()
    {
        super();
        action = "Wander";
        toString = ["speed"];
    }
}
}
