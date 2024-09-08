package Engine {
import Display.Assets.Objects.BasicObject;

import Engine.File.Parameters;

import flash.display.Sprite;
import flash.geom.Point;

public class TileMap extends Sprite {

    private var tiles:Array;
    private var map:Map;

    public var mapWidth:int;
    public var mapHeight:int;

    public function TileMap(map:Map, objType:int) {
        this.map = map;
        this.mapWidth = Parameters.data_["tileMapWidth"];
        this.mapHeight = Parameters.data_["tileMapHeight"];

        tiles = new Array(mapWidth * mapHeight);
        for (var y:int = 0; y < mapHeight; y++) {
            for (var x:int = 0; x < mapWidth; x++) {
                var basicObject:BasicObject = new BasicObject(map, objType);
                setTile(x, y, objType);
                basicObject.x = x * Main.TILE_SIZE + Main.TILE_SIZE / 2;
                basicObject.y = y * Main.TILE_SIZE + Main.TILE_SIZE / 2;
                basicObject.size = Main.TILE_SIZE;
                tiles[y * mapWidth + x] = basicObject;
                map.addObj(basicObject);
            }
        }
    }

    public function getCoords(x:Number, y:Number):Point
    {
        var inputX:Number = x * Main.TILE_SIZE;
        var inputY:Number = y * Main.TILE_SIZE;
        var maxX:Number = this.mapWidth * Main.TILE_SIZE;
        var maxY:Number = this.mapHeight * Main.TILE_SIZE;
        return new Point(inputX > maxX ? maxX : inputX,
                         inputY > maxY ? maxY : inputY);
    }

    public function centerCamera(x:Number, y:Number, xOffset:int = 0, yOffset:int = 0):Point
    {
        var tX:Number = x * (this.mapWidth * Main.TILE_SIZE);
        var tY:Number = y * (this.mapHeight * Main.TILE_SIZE);
        return new Point(tX - (Main.STAGE.stageWidth / 2) + xOffset, tY - (Main.STAGE.stageHeight / 2) + yOffset);
    }

    public function setCoordsCenter(bo:BasicObject, x:Number, y:Number):void
    {
        var tX:Number = x * (this.mapWidth * Main.TILE_SIZE);
        var tY:Number = y * (this.mapHeight * Main.TILE_SIZE);
        bo.x = tX;
        bo.y = tY;
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
