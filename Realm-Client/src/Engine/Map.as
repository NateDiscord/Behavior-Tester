package Engine {
import Display.Assets.Objects.BasicObject;
import flash.display.Sprite;

public class Map extends Sprite {

    public function Map() {
    }

    public function addObj(obj:BasicObject) : void {
        addChild(obj);
    }

    public  function removeObj(obj:BasicObject) : void {
        removeChild(obj);
    }
}
}
