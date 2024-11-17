package Engine.Interface.Editor {
import Engine.Interface.Editor.Behaviors.BehaviorCell;
import Engine.Interface.Editor.States.StateCell;

public class NewCell extends BehaviorCell {
    public function NewCell(index:int, host:StateCell) {
        super(index, host, null);
    }
}
}
