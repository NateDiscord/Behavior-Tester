package {
import Display.Assets.AssetLoader;

import Engine.Behaviors.Modals.BehaviorDb;
import Engine.Behaviors.Modals.Shoot;
import Engine.Behaviors.Modals.State;
import Engine.Behaviors.Parser;

import Engine.File.FileReader;

import Engine.GameManager;

import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageScaleMode;
import flash.events.Event;

[SWF(frameRate="60",backgroundColor="#000000",width="800",height="600")]
public class WebClient extends Sprite {
    public static var STAGE:Stage;
    public var manager:GameManager;

    public function WebClient()
    {
        super();
        if(stage)
            this.setup();
        else
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);

        //read behavior file then load game
        new FileReader(onFileLoaded, "Resources/Behaviors/BehaviorDB.Test.txt");
    }

    private function onFileLoaded(content:String):void {
        var behavior:BehaviorDb = Parser.ParseData(content);
        loadGame(behavior);
    }

    private function loadGame(behavior:BehaviorDb) : void
    {
        if (!this.manager)
            this.manager = new GameManager(behavior);
        addChild(this.manager);
    }

    private function onAddedToStage(event:Event) : void
    {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        setup();
    }

    private function setup() : void
    {
        new AssetLoader().load();
        stage.scaleMode = StageScaleMode.NO_SCALE;
        STAGE = stage;
    }
}
}
