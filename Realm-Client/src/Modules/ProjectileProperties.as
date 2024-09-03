package Modules {

public class ProjectileProperties
{
    public var projectileIndex_:int;
    public var objectId_:String;
    public var lifetime_:Number;
    public var speed_:Number;
    public var size_:int;

    public function ProjectileProperties(projectileXML:XML)
    {
        super();
        this.projectileIndex_ = int(projectileXML.@id);
        this.objectId_ = projectileXML.ObjectId;
        this.lifetime_ = int(projectileXML.LifetimeMS);
        this.speed_ = Number(projectileXML.Speed) * 40;
        this.size_ = Boolean(projectileXML.hasOwnProperty("Size"))?int(Number(projectileXML.Size)):int(-1);
    }
}
}