package Engine {
import Display.Assets.Objects.BasicObject;

import flash.display.Sprite;

public class TileMap extends Sprite {
    private var tiles:Array;
    private var tileSize:int;
    private var mapWidth:int;
    private var mapHeight:int;
    private var map:Map;

    public function TileMap(map:Map, mapWidth:int, mapHeight:int, tileSize:int, objType:int) {
        this.map = map;
        this.mapWidth = mapWidth;
        this.mapHeight = mapHeight;
        this.tileSize = tileSize;

        tiles = new Array(mapWidth * mapHeight);
        for (var y:int = 0; y < mapHeight; y++) {
            for (var x:int = 0; x < mapWidth; x++) {
                var basicObject:BasicObject = new BasicObject(map, objType);
                setTile(x, y, objType);
                basicObject.x = x * tileSize + tileSize / 2;
                basicObject.y = y * tileSize + tileSize / 2;
                basicObject.size = tileSize;
                tiles[y * mapWidth + x] = basicObject;
                map.addObj(basicObject);
            }
        }
    }

    public function setTile(x:int, y:int, objectType:int):void {
        if (x >= 0 && x < mapWidth && y >= 0 && y < mapHeight) {
            var index:int = y * mapWidth + x;
            var basicObject:BasicObject = tiles[index];
            if (basicObject) {
                basicObject.objectType = objectType;
                basicObject.redrawBitmap();
            }
        }
    }

    public function clear():void {
        for each (var basicObject:BasicObject in tiles) {
            if (basicObject) {
                removeChild(basicObject);
                basicObject.map.removeObj(basicObject); // If map manages objects
            }
        }
        tiles = new Array(mapWidth * mapHeight); // Reset the array
    }
}
}
