package Engine {
import Display.Assets.Objects.BasicObject;
import Display.Assets.Objects.Entity;
import flash.utils.Dictionary;
import flash.events.Event;

public class TileMap extends Map {

    private var tiles:Object;
    private var updateQueue:Array;
    private var processingQueue:Boolean;
    private var manager:Manager;
    private var objType:int;

    private var camera:Camera;
    private var map:Map;

    private var radius:int = 15;

    public function TileMap(manager:Manager, objType:int) {
        this.manager = manager;
        this.objType = objType;
        tiles = {};
        updateQueue = [];
        processingQueue = false;
    }

    public function onCameraSetup(camera:Camera, map:Map):void {
        this.camera = camera;
        this.map = map;
        updateTilesBasedOnCamera(camera.position.x, camera.position.y);
    }

    public function updateTilesBasedOnCamera(cameraX:Number, cameraY:Number):void {
        var tileX:int = Math.floor(cameraX / Main.TILE_SIZE);
        var tileY:int = Math.floor(cameraY / Main.TILE_SIZE);
        queueTileUpdates(tileX, tileY);
        if (!processingQueue) {
            processingQueue = true;
            processTileQueue();
        }
        removeOutOfBoundsTiles(tileX, tileY);
    }

    private function queueTileUpdates(centerX:int, centerY:int):void {
        var startX:int = centerX - radius;
        var startY:int = centerY - radius;
        var endX:int = centerX + radius;
        var endY:int = centerY + radius;
        for (var y:int = startY; y <= endY; y++)
            for (var x:int = startX; x <= endX; x++)
                if (isWithinRadius(centerX, centerY, x, y))
                    if (!tiles[x + "," + y])
                        updateQueue.push({x: x, y: y});
    }

    private function processTileQueue():void {
        var maxUpdates:int = int.MAX_VALUE;
        var updatesProcessed:int = 0;
        while (updateQueue.length > 0 && updatesProcessed < maxUpdates) {
            var tileData:Object = updateQueue.shift();
            var x:int = tileData.x;
            var y:int = tileData.y;
            var tileKey:String = x + "," + y;
            if (!tiles[tileKey]) {
                var basicObject:BasicObject = new BasicObject(this.map, this.objType);
                basicObject.x = x * Main.TILE_SIZE;
                basicObject.y = y * Main.TILE_SIZE;
                basicObject.size = Main.TILE_SIZE;
                tiles[tileKey] = basicObject;
                this.addObj(basicObject);
            }
            updatesProcessed++;
        }
        if (updateQueue.length > 0)
            manager.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        else
            processingQueue = false;
    }

    private function onEnterFrame(event:Event):void {
        if (updateQueue.length == 0)
            manager.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        processTileQueue();
    }

    public function removeOutOfBoundsTiles(centerX:int, centerY:int):void {
        var keysToRemove:Array = [];
        for (var tileKey:String in tiles) {
            var coords:Array = tileKey.split(",");
            var tileX:int = int(coords[0]);
            var tileY:int = int(coords[1]);

            if (!isWithinRadius(centerX, centerY, tileX, tileY)) {
                var tile:BasicObject = tiles[tileKey];
                this.removeObj(tile);
                keysToRemove.push(tileKey);
            }
        }
        for each (var key:String in keysToRemove)
            delete tiles[key];
    }

    private function isWithinRadius(centerX:int, centerY:int, x:int, y:int):Boolean {
        var dx:int = x - centerX;
        var dy:int = y - centerY;
        return (dx * dx + dy * dy) <= (this.radius * this.radius);
    }

    public function isEntityWithinTilemap(entity:BasicObject):Boolean {
        var tileX:int = Math.floor(entity.x / Main.TILE_SIZE);
        var tileY:int = Math.floor(entity.y / Main.TILE_SIZE);
        var centerX:int = Math.floor(camera.position.x / Main.TILE_SIZE);
        var centerY:int = Math.floor(camera.position.y / Main.TILE_SIZE);
        return isWithinRadius(centerX, centerY, tileX, tileY);
    }
}
}
