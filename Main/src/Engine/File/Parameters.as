package Engine.File
{
import Display.Assets.Objects.Entity;
import Display.Util.KeyUtil;
import flash.net.SharedObject;
import flash.utils.Dictionary;

public class Parameters
{
    public static const BUILD:String = "v1.0";
    public static var data_:Object = null;
    private static var savedOptions_:SharedObject = null;
    private static var keyNames_:Dictionary = new Dictionary();

    public function Parameters()
    {
        super();
    }

    public static function load() : void
    {
        try
        {
            savedOptions_ = SharedObject.getLocal("OWSettings","/");
            data_ = savedOptions_.data;
        }
        catch(error:Error)
        {
            trace("WARNING: unable to save settings");
            data_ = new Object();
        }
        Parameters.data_["entities"] = null;
        setDefaults();
        save();
    }

    public static function save() : void
    {
        try
        {
            if(savedOptions_ != null)
            {
                savedOptions_.flush();
            }
        }
        catch(error:Error)
        {
        }
    }

    private static function setDefaultKey(keyName:String, key:uint) : void
    {
        if(!data_.hasOwnProperty(keyName))
        {
            data_[keyName] = key;
        }
        keyNames_[keyName] = true;
    }

    public static function setKey(keyName:String, key:uint) : void
    {
        var otherKeyName:* = null;
        for(otherKeyName in keyNames_)
        {
            if(data_[otherKeyName] == key)
            {
                data_[otherKeyName] = KeyUtil.UNSET;
            }
        }
        data_[keyName] = key;
    }

    private static function setDefault(keyName:String, value:*) : void
    {
        if(!data_.hasOwnProperty(keyName))
        {
            data_[keyName] = value;
        }
    }

    public static function setDefaults() : void
    {
        setDefaultKey("cameraUp", KeyUtil.UP);
        setDefaultKey("cameraDown", KeyUtil.DOWN);
        setDefaultKey("cameraLeft", KeyUtil.LEFT);
        setDefaultKey("cameraRight", KeyUtil.RIGHT);
        setDefault("tileMapWidth", 50);
        setDefault("tileMapHeight", 50);
        setDefault("cameraSpeed", 5);
        setDefault("projectileOutlines", true);
        setDefault("entities", null)
    }
}
}
