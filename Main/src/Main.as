package {
import Display.Assets.AssetLoader;
import Display.Assets.Objects.Entity;

import Engine.Behaviors.Modals.BehaviorDb;
import Engine.Behaviors.Modals.Shoot;
import Engine.Behaviors.Modals.State;
import Engine.Behaviors.Parser;

import Engine.File.FileReader;
import Engine.File.Parameters;

import Engine.Manager;

import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

[SWF(frameRate="60",backgroundColor="#000000",width="1280",height="720")]
public class Main extends Sprite {

    public var manager:Manager;

    public static var STAGE:Stage;
    public static var CURRENT_ENTITY:Entity;
    public static var CURRENT_BEHAVIOR:BehaviorDb;

    public function Main()
    {
        super();
        if(stage)
            setup();
        else
            addEventListener("addedToStage",this.onAddedToStage);
        new FileReader(onFileLoaded, "Resources/Behaviors/BehaviorDB.Test.txt");
    }

    private function onFileLoaded(content:String):void {
        var behavior:BehaviorDb = Parser.ParseData(content);
        loadGame(behavior);
    }

    private function loadGame(behavior:BehaviorDb) : void
    {
        CURRENT_BEHAVIOR = behavior;
        if (!this.manager)
            this.manager = new Manager(behavior);
        addChild(this.manager);
    }

    private function onAddedToStage(e:Event) : void
    {
        removeEventListener("addedToStage", onAddedToStage);
        setup();
    }

    private function setup() : void
    {
        new AssetLoader().load();
        Parameters.load();
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        STAGE = stage;
    }
}
}
