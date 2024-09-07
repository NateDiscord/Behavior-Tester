package Engine {
import Display.Assets.Objects.BasicObject;
import Display.Assets.Objects.Entity;
import Display.Control.ObjectLibrary;
import Engine.Behaviors.CycleLogic;
import Engine.Behaviors.Modals.BehaviorDb;
import Engine.File.Parameters;
import Engine.Interface.Editor.EditorPanel;
import Engine.Interface.Interface;

import flash.display.Bitmap;

import flash.display.BitmapData;

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.utils.getTimer;

public class Manager extends Sprite {
    private var map:Map;
    public var camera:Camera;
    public var gui:Interface;
    public var tileMap:TileMap;
    private var tileLayer:Sprite;
    public var behavior:BehaviorDb;
    private var cycleLogic:CycleLogic;
    private var lastUpdateTime:Number;
    public var time:Number = 0;
    public var deltaTime:Number = 0;

    public function Manager(behaviorData:BehaviorDb) {
        this.behavior = behaviorData;

        addMaps();
        spawnEntities();
        addCamera();
        addInterface();

        /* initialize CycleLogic. */
        this.cycleLogic = new CycleLogic(this.map, this.behavior, 0);
        addEventListener("enterFrame", onEnterFrame);
        Main.STAGE.addEventListener("resize", onResize);
    }

    private function addMaps():void
    {
        this.map = new Map();
        this.tileMap = new TileMap(this.map, 0xc6f);
        this.tileLayer = new Sprite();
        addChild(this.tileLayer);
    }

    private function addCamera():void
    {
        var offset:Number = -(EditorPanel.INSET_WIDTH / 2);
        var coords:Point = this.tileMap.centerCamera(0.5, 0.5, offset);
        this.camera = new Camera(this.map, this.tileMap, coords);
        addChild(this.camera);
    }

    private function spawnEntities():void
    {
        if (Parameters.data_["entities"] == null)
        {
            var vec:Vector.<Entity> = new Vector.<Entity>();
            var obj:Entity = new Entity(this.map, ObjectLibrary.idToType_[this.behavior.name_]);
            vec.push(obj);
            Parameters.data_["entities"] = vec;
            Main.CURRENT_ENTITY = obj;
        }

        var defaults:Vector.<Entity> = Parameters.data_["entities"];
        var entity:Entity = defaults[0];
        this.tileMap.setCoordsCenter(entity, 0.5, 0.5);
        this.map.addObj(entity);
    }

    private function addInterface():void
    {
        this.gui = new Interface(this);
        addChild(this.gui);
    }

    private function onResize(e:Event):void
    {
        Main.windowWidth = stage.stageWidth;
        Main.windowHeight = stage.stageHeight;
        this.camera.adjustPosition();
        this.gui.onResize();
    }

    private function onEnterFrame(event:Event):void {
        var currentTime:Number = getTimer();
        this.deltaTime = (currentTime - this.time) / 1000;
        this.time = currentTime;
        for (var i:int = this.map.numChildren - 1; i >= 0; i--) {
            var child:BasicObject = this.map.getChildAt(i) as BasicObject;
            if (child)
                child.update(currentTime);
        }
	
        this.cycleLogic.update(this.time);
        this.lastUpdateTime = currentTime;
    }
}
}
