package Engine {
import Display.Assets.Objects.BasicObject;
import flash.display.Sprite;

public class Map extends Sprite {
    public function Map() {
    }

    public function AddObj(obj:BasicObject) : void {
        this.addChild(obj);
    }

    public  function RemoveObj(obj:BasicObject) : void {
        this.removeChild(obj);
    }
}
}
