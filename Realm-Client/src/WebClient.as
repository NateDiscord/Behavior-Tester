package {
import Display.Assets.AssetLoader;

import Engine.Map;

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
        this.addChild(new Map());
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
