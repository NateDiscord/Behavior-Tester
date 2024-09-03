package Engine {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Point;
import flash.ui.Keyboard;

public class Camera extends Sprite {

    public static var MOVE_SPEED:int = 5;

    private var map:Map;
    private var tileMap:TileMap;
    private var position:Point;
    private var lastWindowSize:Point;

    public function Camera(map:Map, tileMap:TileMap, startPos:Point = null) {
        this.position = startPos || new Point(0, 0);
        this.lastWindowSize = new Point(Main.STAGE.stageWidth, Main.STAGE.stageHeight);

        this.tileMap = tileMap;
        addChild(this.tileMap);
        this.map = map;
        addChild(this.map);

        addEventListener(Event.ENTER_FRAME, onEnterFrame);
        Main.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        Main.STAGE.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        Main.STAGE.addEventListener(Event.RESIZE, onResize);
    }

    private var keys:Object = {};

    private function onKeyDown(e:KeyboardEvent):void {
        keys[e.keyCode] = true;
    }

    private function onKeyUp(e:KeyboardEvent):void {
        keys[e.keyCode] = false;
    }

    private function onEnterFrame(e:Event):void {
        if (keys[Keyboard.LEFT]) {
            position.x -= MOVE_SPEED;
        }
        if (keys[Keyboard.RIGHT]) {
            position.x += MOVE_SPEED;
        }
        if (keys[Keyboard.UP]) {
            position.y -= MOVE_SPEED;
        }
        if (keys[Keyboard.DOWN]) {
            position.y += MOVE_SPEED;
        }

        updateCamera();
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

    private function updateCamera():void {
        map.x = -position.x;
        map.y = -position.y;
        tileMap.x = -position.x;
        tileMap.y = -position.y;
    }

    public function adjustPosition():void {
        updateCamera();
    }

    public function moveTo(newX:Number, newY:Number):void {
        this.position.x = newX;
        this.position.y = newY;
        updateCamera();
    }
}
}
