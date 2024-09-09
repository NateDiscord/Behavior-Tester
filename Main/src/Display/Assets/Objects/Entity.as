package Display.Assets.Objects {
import Display.Control.ObjectLibrary;

import Engine.Map;

import Modules.ProjectileProperties;

import flash.utils.Dictionary;


public class Entity extends BasicObject {
    public var name_:String;
    public var map_:Map;
    public var projectiles_:Dictionary = new Dictionary();
    public var xml_:XML;
    public var isVisible:Boolean;

    public function Entity(map:Map, objectType:int) {
        super(map, objectType, 100, true);
        this.name_ = ObjectLibrary.typeToId_[objectType];
        this.map_ = map;
        this.xml_ = ObjectLibrary.xmlLibrary_[objectType];
        this.isVisible = true;
        this.projectiles_ = new Dictionary();
        for each(var projectileXML:XML in this.xml_.Projectile) {
            var bulletIndex:int = int(projectileXML.@id);
            this.projectiles_[bulletIndex] = new ProjectileProperties(projectileXML);
        }
    }
}
}
