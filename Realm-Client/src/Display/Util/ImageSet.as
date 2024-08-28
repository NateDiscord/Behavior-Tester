package Display.Util {
import flash.display.BitmapData;

public class ImageSet {
    public var images:Vector.<BitmapData>;

    public function ImageSet() {
        images = new Vector.<BitmapData>();
    }

    public function add(image:BitmapData):void {
        images.push(image);
    }

    public function addFromBitmapData(source:BitmapData, tileWidth:int, tileHeight:int):void {
        var columns:int = source.width / tileWidth;
        var rows:int = source.height / tileHeight;

        for (var row:int = 0; row < rows; row++) {
            for (var column:int = 0; column < columns; column++) {
                var x:int = column * tileWidth;
                var y:int = row * tileHeight;
                var tile:BitmapData = BitmapUtil.cropToBitmapData(source, x, y, tileWidth, tileHeight);
                images.push(tile);
            }
        }
    }
}
}
