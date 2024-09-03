package Display.Assets.Objects {
import Display.Control.ObjectLibrary;
import Display.Control.Redrawers.TextureRedrawer;

import Engine.Map;

import flash.display.Bitmap;

import flash.display.BitmapData;

import flash.display.Sprite;

public class BasicObject extends Sprite {
    public var map:Map;
    public var texture:Bitmap;
    public var objectType:int;
    public var size:int;

    public function BasicObject(map:Map, objectType:int, size:int = 100) {
        super();
        this.map = map;
        this.objectType = objectType;
        this.size = size;
        this.RedrawBitmap();
        this.texture.x = this.texture.x - (this.texture.width / 2);
        this.texture.y = this.texture.y - (this.texture.height / 2);
    }

    private function RedrawBitmap() : void {
        var bitmap:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this.objectType);
        bitmap = TextureRedrawer.redraw(bitmap, this.size, true, 0);
        this.texture = new Bitmap(bitmap);
        this.addChild(this.texture);
    }

    public function update(time:int) : Boolean
    {
        return true;
    }
}
}
