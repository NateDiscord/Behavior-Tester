package Modules {

public class ProjectileProperties
{
    public var projectileIndex_:int;
    public var objectId_:String;
    public var lifetime_:Number;
    public var speed_:Number;
    public var size_:int;

    public var wavy_:Boolean;

    public var parametric_:Boolean;
    public var boomerang_:Boolean;
    public var amplitude_:Number;
    public var frequency_:Number;
    public var magnitude_:Number;

    public function ProjectileProperties(projectileXML:XML)
    {
        super();
        this.projectileIndex_ = int(projectileXML.@id);
        this.objectId_ = projectileXML.ObjectId;
        this.lifetime_ = int(projectileXML.LifetimeMS);
        this.speed_ = Number(projectileXML.Speed) * 40;
        this.size_ = Boolean(projectileXML.hasOwnProperty("Size"))?int(Number(projectileXML.Size)):int(-1);

        this.wavy_ = projectileXML.hasOwnProperty("Wavy");
        this.parametric_ = projectileXML.hasOwnProperty("Parametric");
        this.boomerang_ = projectileXML.hasOwnProperty("Boomerang");
        this.amplitude_ = Boolean(projectileXML.hasOwnProperty("Amplitude"))?Number(Number(projectileXML.Amplitude)):Number(0);
        this.frequency_ = Boolean(projectileXML.hasOwnProperty("Frequency"))?Number(Number(projectileXML.Frequency)):Number(1);
        this.magnitude_ = Boolean(projectileXML.hasOwnProperty("Magnitude"))?Number(Number(projectileXML.Magnitude)):Number(3);
    }
}
}