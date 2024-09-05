package Display.Control {
import Display.Control.Redrawers.TextureData;

import flash.display.BitmapData;
import flash.utils.Dictionary;

public class ObjectLibrary {
    public static const IMAGE_SET_NAME:String = "lofiObj5";
    public static const IMAGE_ID:int = 0xFF;
    public static const xmlLibrary_:Dictionary = new Dictionary();
    public static const idToType_:Dictionary = new Dictionary();
    public static const typeToId_:Dictionary = new Dictionary();
    public static const typeToTextureData_:Dictionary = new Dictionary();

    public function ObjectLibrary()
    {
        super();
    }

    public static function parseFromXML(xml:XML) : void
    {
        var objectXML:XML = null;
        var id:String = null;
        var displayId:String = null;
        var objectType:int = 0;
        var found:Boolean = false;
        var i:int = 0;
        for each(objectXML in xml.Object)
        {
            id = String(objectXML.@id);
            displayId = id;
            objectType = int(objectXML.@type);
            xmlLibrary_[objectType] = objectXML;
            idToType_[id] = objectType;
            typeToTextureData_[objectType] = new TextureData(objectXML);
        }
    }

    public static function getIdFromType(type:int) : String
    {
        var objectXML:XML = xmlLibrary_[type];
        if(objectXML == null)
        {
            return null;
        }
        return String(objectXML.@id);
    }

    public static function getXMLfromId(id:String) : XML
    {
        var objectType:int = idToType_[id];
        return xmlLibrary_[objectType];
    }

    public static function getTextureFromType(objectType:int) : BitmapData
    {
        var textureData:TextureData = typeToTextureData_[objectType];
        if(textureData == null)
        {
            return null;
        }
        return textureData.getTexture();
    }

    public static function getRedrawnTextureFromType(objectType:int) : BitmapData
    {
        var xml:XML = ObjectLibrary.xmlLibrary_[objectType];
        var fileName:String = xml.Texture[0].File;
        var index:int = xml.Texture[0].Index;
        return AssetLibrary.getImageFromSet(fileName,index);
    }

    public static function getSizeFromType(objectType:int) : int
    {
        var objectXML:XML = xmlLibrary_[objectType];
        if(!objectXML.hasOwnProperty("Size"))
        {
            return 100;
        }
        return int(objectXML.Size);
    }
}
}