package Modules {
import Display.Assets.Objects.BasicObject;
import Display.Assets.Objects.Entity;
import Display.Control.ObjectLibrary;
import Display.Util.Trig;
import Engine.Map;
import flash.geom.Point;

public class Projectile extends BasicObject
{
    public var projProps:ProjectileProperties;
    public var startTime_:int;
    public var angle_:Number;
    private var staticPoint_:Point;

    public function Projectile(map:Map, host:Entity, projProps:ProjectileProperties, angle:Number, startTime:int) {
        this.projProps = projProps;
        this.startTime_ = startTime;
        this.angle_ = Trig.boundToPI(angle);
        this.x = host.x;
        this.y = host.y;
        this.staticPoint_ = new Point(this.x, this.y);
        var objectType:int = ObjectLibrary.idToType_[this.projProps.objectId_];
        var objectXML:XML = ObjectLibrary.xmlLibrary_[objectType];
        this.rotation = angle * (180 / Math.PI);
        if (objectXML.hasOwnProperty("AngleCorrection")) {
            var angleCorrection:Number = Number(objectXML.AngleCorrection);
            angleCorrection = angleCorrection * 0.8* (180 / Math.PI);
            this.rotation += angleCorrection;
        }
        super(map, objectType, this.projProps.size_);
    }

    private function positionAt(elapsed:int, p:Point):void {
        p.x = this.staticPoint_.x;
        p.y = this.staticPoint_.y;
        var dist:Number = elapsed * (this.projProps.speed_ / 10000);
        p.x = p.x + dist * Math.cos(this.angle_);
        p.y = p.y + dist * Math.sin(this.angle_);
    }

    override public function update(time:int) : Boolean {
        var elapsed:int = time - this.startTime_;
        if (elapsed > this.projProps.lifetime_) {
            this.map.removeChild(this);
            return false;
        }
        var p:Point = new Point();
        this.positionAt(elapsed, p);
        this.x = p.x;
        this.y = p.y;
        return true;
    }
}
}