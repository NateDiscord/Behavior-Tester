package Display.Control.Redrawers {
import Display.Control.*;

import flash.display.BitmapData;

public class TextureData {
    public var texture_:BitmapData = null;
    public var mask_:BitmapData = null;

    public function TextureData(objectXML:XML)
    {
        super();
        this.parse(objectXML);
    }

    private function parse(xml:XML) : void
    {
        switch(xml.name().toString())
        {
            case "Texture":
                this.texture_ = AssetLibrary.getImageFromSet(String(xml.File),int(xml.Index));
                break;
            case "Mask":
                this.mask_ = AssetLibrary.getImageFromSet(String(xml.File),int(xml.Index));
                break;
        }
    }

    public function getTexture(_arg1:int = 0):BitmapData {
        return (null);
    }
}
}