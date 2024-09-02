package Engine {
import Display.Assets.Objects.Entity;

import flash.display.Sprite;

public class Map extends Sprite {
    public function Map() {
    }

    public function FindEntity(objectType:int):Entity {
        for (var i:int = 0; i < this.numChildren; i++) {
            var child:Entity = this.getChildAt(i) as Entity;
            if (child && child.objectType == objectType) {
                return child;
            }
        }
        return null;
    }

}
}
