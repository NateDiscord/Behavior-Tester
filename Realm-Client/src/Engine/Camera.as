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
    private var speed:int = 5;

    public function Camera(map:Map, tileMap:TileMap) {
        this.position = new Point(0, 0);

        this.tileMap = tileMap;
        addChild(this.tileMap);
        this.map = map;
        addChild(this.map);

        addEventListener("enterFrame", onEnterFrame);
        Main.STAGE.addEventListener("keyDown", onKeyDown);
        Main.STAGE.addEventListener("keyUp", onKeyUp);
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
        map.x = -position.x;
        map.y = -position.y;
        tileMap.x = -position.x;
        tileMap.y = -position.y;
    }

    public function adjustPosition():void
    {
        position.x = -((Main.windowWidth / 2) - (800 / 2));
        position.y = -((Main.windowHeight / 2) - (600 / 2));

        map.x = -position.x;
        map.y = -position.y;
        tileMap.x = -position.x;
        tileMap.y = -position.y;
    }

    // Function to move the camera to a new position
    public function moveTo(newX:Number, newY:Number):void {
        this.position.x = newX;
        this.position.y = newY;
    }
}
}
