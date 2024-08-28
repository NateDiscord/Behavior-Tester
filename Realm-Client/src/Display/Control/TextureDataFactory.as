package Display.Control {

import flash.display.BitmapData;

public class TextureDataFactory extends TextureData {
    private var texId:String;

    public function TextureDataFactory(_arg1:XML) {
        super();
        if (_arg1.hasOwnProperty("Texture")) {
            this.parse(XML(_arg1.Texture));
        }
    }

    override public function getTexture(_arg1:int = 0):BitmapData {
        return (texture_);
    }

    private function parse(xml:XML):void {
        switch (xml.name().toString()) {
            case "Texture":
                try {
                    texture_ = AssetLibrary.getImageFromSet(String(xml.File), int(xml.Index));
                }
                catch (error:Error) {
                    throw (new Error(((("Error loading Texture - name: " + String(xml.File)) + " - idx: ") + int(xml.Index))));
                }
                return;
        }
    }

    public function id():String {
        return this.texId;
    }


}
}