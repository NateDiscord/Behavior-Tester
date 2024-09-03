package Display.Assets.Objects {
import Display.Control.ObjectLibrary;

import Engine.Map;

import Modules.ProjectileProperties;

import flash.utils.Dictionary;


public class Entity extends BasicObject {
    public var name_:String;
    public var projectiles_:Dictionary = new Dictionary();

    public function Entity(map:Map, objectType:int) {
        super(map, objectType);
        this.name_ = ObjectLibrary.typeToId_[objectType];
        var objectXML:XML = ObjectLibrary.xmlLibrary_[objectType];
        this.projectiles_ = new Dictionary();
        for each(var projectileXML:XML in objectXML.Projectile) {
            var bulletIndex:int = int(projectileXML.@id);
            this.projectiles_[bulletIndex] = new ProjectileProperties(projectileXML);
        }
    }
}
}
