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
            angleCorrection = angleCorrection * 0.8 * (180 / Math.PI);
            this.rotation += angleCorrection;
        }
        super(map, objectType, this.projProps.size_, true);
    }

    private function positionAt(elapsed:int, p:Point) : void
    {
        var periodFactor:Number;
        var amplitudeFactor:Number;
        var theta:Number;
        var t:Number;
        var x:Number;
        var y:Number;
        var sinAngle:Number;
        var cosAngle:Number;
        var halfwayDist:Number;
        var deflection:Number;
        p.x = this.staticPoint_.x;
        p.y = this.staticPoint_.y;
        var distance:Number = elapsed * (this.projProps.speed_ / 10000);
        var phase:Number = (this.objectType % 2 == 0) ? 0 : Math.PI;
        if (this.projProps.wavy_)
        {
            periodFactor = 6 * Math.PI;
            amplitudeFactor = Math.PI / 64;
            theta = this.angle_ + amplitudeFactor * Math.sin(phase + periodFactor * elapsed / 1000);
            p.x += distance * Math.cos(theta);
            p.y += distance * Math.sin(theta);
        }
        else if (this.projProps.parametric_)
        {
            t = elapsed / this.projProps.lifetime_ * 2 * Math.PI;
            x = Math.sin(t) * ((this.objectType % 2) ? 1 : -1);
            y = Math.sin(2 * t) * ((this.objectType % 4 < 2) ? 1 : -1);
            sinAngle = Math.sin(this.angle_);
            cosAngle = Math.cos(this.angle_);
            p.x += (x * cosAngle - y * sinAngle) * this.projProps.magnitude_;
            p.y += (x * sinAngle + y * cosAngle) * this.projProps.magnitude_;
        }
        else
        {
            if (this.projProps.boomerang_)
            {
                halfwayDist = this.projProps.lifetime_ * (this.projProps.speed_ / 10000) / 2;
                if (distance > halfwayDist)
                {
                    distance = halfwayDist - (distance - halfwayDist);
                }
            }
            p.x += distance * Math.cos(this.angle_);
            p.y += distance * Math.sin(this.angle_);
            if (this.projProps.amplitude_ != 0)
            {
                deflection = this.projProps.amplitude_ * Math.sin(phase + elapsed / this.projProps.lifetime_ * this.projProps.frequency_ * 2 * Math.PI);
                p.x += deflection * Math.cos(this.angle_ + Math.PI / 2);
                p.y += deflection * Math.sin(this.angle_ + Math.PI / 2);
            }
        }
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