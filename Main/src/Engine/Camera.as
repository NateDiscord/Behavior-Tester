package Engine {
import Display.Assets.Objects.Entity;

import Engine.File.Parameters;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Keyboard;

public class Camera extends Sprite {

    public var map:Map;
    public var tileMap:TileMap;
    public var position:Point;
    private var lastWindowSize:Point;
    private var scaleStep:Number = 0.02;

    public function Camera(map:Map, tileMap:TileMap, startPos:Point = null) {
        this.position = startPos || new Point(0, 0);
        this.lastWindowSize = new Point(Main.STAGE.stageWidth, Main.STAGE.stageHeight);

        this.tileMap = tileMap;
        addChild(this.tileMap);

        this.map = map;
        addChild(this.map);

        this.tileMap.onCameraSetup(this, map);

        addEventListener(Event.ENTER_FRAME, onEnterFrame);
        Main.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        Main.STAGE.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        Main.STAGE.addEventListener(Event.RESIZE, onResize);
        Main.STAGE.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
    }

    private var keys:Object = {};

    private function onKeyDown(e:KeyboardEvent):void {
        keys[e.keyCode] = true;
    }

    private function onKeyUp(e:KeyboardEvent):void {
        keys[e.keyCode] = false;
    }

    private function onEnterFrame(e:Event):void {
        var speed:Number = Parameters.data_["cameraSpeed"];
        if (keys[Keyboard.LEFT])
            position.x -= speed;
        if (keys[Keyboard.RIGHT])
            position.x += speed;
        if (keys[Keyboard.UP])
            position.y -= speed;
        if (keys[Keyboard.DOWN])
            position.y += speed;

        updateCamera();
        tileMap.updateTilesBasedOnCamera(position.x, position.y);
        map.updateEntityVisibility(tileMap);
    }

    private function onResize(e:Event):void {
        var newSize:Point = new Point(Main.STAGE.stageWidth, Main.STAGE.stageHeight);
        var offsetX:Number = (newSize.x - lastWindowSize.x) / 2;
        var offsetY:Number = (newSize.y - lastWindowSize.y) / 2;

        position.x -= offsetX;
        position.y -= offsetY;
        lastWindowSize = newSize;
        updateCamera();
    }

    private function onMouseWheel(e:MouseEvent):void {
        if (keys[Keyboard.CONTROL]) {
            if (e.delta > 0) {
                scaleX += scaleStep;
                scaleY += scaleStep;
            } else if (e.delta < 0) {
                scaleX -= (scaleX < 0.8) ? 0 : scaleStep;
                scaleY -= (scaleY < 0.8) ? 0 : scaleStep;
            }
            updateCamera();
        }
    }

    private function updateCamera():void {
        var stageWidth:Number = Main.STAGE.stageWidth;
        var stageHeight:Number = Main.STAGE.stageHeight;

        var offsetX:Number = (stageWidth / 2) - (position.x * scaleX);
        var offsetY:Number = (stageHeight / 2) - (position.y * scaleY);

        map.x = offsetX;
        map.y = offsetY;
        tileMap.x = offsetX;
        tileMap.y = offsetY;

        map.scaleX = scaleX;
        map.scaleY = scaleY;
        tileMap.scaleX = scaleX;
        tileMap.scaleY = scaleY;

        for (var i:int = 0; i < map.numChildren; i++) {
            var child:Entity = map.getChildAt(i) as Entity;
            if (child)
                if (tileMap.isEntityWithinTilemap(child)) {
                    child.isVisible = true;
                    child.visible = true;
                } else {
                    child.isVisible = false;
                    child.visible = false;
                }
        }
    }

    public function adjustPosition():void {
        updateCamera();
    }
}
}
