package Engine {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Point;
import flash.ui.Keyboard;

public class Camera extends Sprite {

    private var map:Map;
    private var position:Point;

    private var speed:int = 5;

    public function Camera(map:Map) {
        this.map = map;
        this.position = new Point(0, 0);
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
            position.x -= speed;
        }
        if (keys[Keyboard.RIGHT]) {
            position.x += speed;
        }
        if (keys[Keyboard.UP]) {
            position.y -= speed;
        }
        if (keys[Keyboard.DOWN]) {
            position.y += speed;
        }

        map.x = -position.x;
        map.y = -position.y;
    }

    public function adjustPosition():void
    {
        position.x = -((Main.windowWidth / 2) - (800 / 2));
        position.y = -((Main.windowHeight / 2) - (600 / 2));

        map.x = -position.x;
        map.y = -position.y;
    }
}
}
