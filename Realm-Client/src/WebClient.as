package {
import Display.Control.AssetLibrary;
import Display.Assets.AssetLoader;
import Display.Control.TextureRedrawer;

import flash.display.Bitmap;

import flash.display.BitmapData;

import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageScaleMode;
import flash.events.Event;

[SWF(frameRate="60",backgroundColor="#000000",width="800",height="600")]
public class WebClient extends Sprite {
    public static var STAGE:Stage;

    public function WebClient()
    {
        super();
        if(stage)
        {
            this.setup();
        }
        else
        {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
        }
        var obj:Bitmap;
        var item:BitmapData = AssetLibrary.getImageFromSet(String("lofiObj5"), int(0x3c));
        item = TextureRedrawer.redraw(item, 100, true, 0);
        obj = new Bitmap(item);
        this.addChild(obj);
    }

    private function onAddedToStage(event:Event) : void
    {
        removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
        this.setup();
    }

    private function setup() : void
    {
        new AssetLoader().load();
        stage.scaleMode = StageScaleMode.EXACT_FIT;
        STAGE = stage;
    }
}
}
