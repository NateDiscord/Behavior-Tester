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
        //read behavior file then load game
        new FileReader(onFileLoaded, "Resources/Behaviors/BehaviorDB.Test.txt");
    }

    private function onFileLoaded(content:String):void {
        var behavior:BehaviorDb = Parser.ParseData(content);
        /*
        trace("Entity Name: " + behavior.name_);
        for (var i:int = 0; i < behavior.statesList_.length; i++) {
            var state:State = behavior.statesList_[i];
            trace("State: " + state.id_);
            for (var j:int = 0; j < state.actions_.length; j++) {
                var shoot:Shoot = state.actions_[j];
                trace("  Shoot Action - Angle: " + shoot.angle + ", CoolDown: " + shoot.coolDown);
            }
        }
        */
        this.loadGame(behavior);
    }

    private function loadGame(behavior:BehaviorDb) : void
    {
        this.addChild(new GameManager(behavior))
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
