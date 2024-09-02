package Display.Assets.Objects {
import Display.Control.ObjectLibrary;

import Engine.Map;


public class Entity extends BasicObject {
    public var name_:String;

    public function Entity(map:Map, objectType:int) {
        super(map, objectType);

        this.name_ = ObjectLibrary.typeToId_[objectType];
    }
}
}
