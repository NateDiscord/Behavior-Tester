package Display.Util {
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

public class BitmapUtil {

    public function BitmapUtil() {
    }

    public static function mirror(source:BitmapData, width:int = 0):BitmapData {
        if (width == 0) {
            width = source.width;
        }
        var mirrored:BitmapData = new BitmapData(source.width, source.height, true, 0);
        for (var x:int = 0; x < width; x++) {
            for (var y:int = 0; y < source.height; y++) {
                mirrored.setPixel32((width - x - 1), y, source.getPixel32(x, y));
            }
        }
        return mirrored;
    }

    public static function rotateBitmapData(source:BitmapData, rotations:int):BitmapData {
        var matrix:Matrix = new Matrix();
        matrix.translate(-source.width / 2, -source.height / 2);
        matrix.rotate(rotations * Math.PI / 2);
        matrix.translate(source.height / 2, source.width / 2);

        var rotated:BitmapData = new BitmapData(source.height, source.width, true, 0);
        rotated.draw(source, matrix);
        return rotated;
    }

    public static function cropToBitmapData(source:BitmapData, x:int, y:int, width:int, height:int):BitmapData {
        var cropped:BitmapData = new BitmapData(width, height);
        cropped.copyPixels(source, new Rectangle(x, y, width, height), new Point(0, 0));
        return cropped;
    }

    public static function amountTransparent(bitmap:BitmapData):Number {
        var transparentPixelCount:int = 0;
        for (var x:int = 0; x < bitmap.width; x++) {
            for (var y:int = 0; y < bitmap.height; y++) {
                if ((bitmap.getPixel32(x, y) & 0xFF000000) == 0) {
                    transparentPixelCount++;
                }
            }
        }
        return transparentPixelCount / (bitmap.width * bitmap.height);
    }

    public static function mostCommonColor(bitmap:BitmapData):uint {
        var colorCount:Dictionary = new Dictionary();
        var mostCommonColor:uint;
        var highestCount:int = 0;

        for (var x:int = 0; x < bitmap.width; x++) {
            for (var y:int = 0; y < bitmap.height; y++) {
                var color:uint = bitmap.getPixel32(x, y);
                if ((color & 0xFF000000) != 0) { // Exclude fully transparent pixels
                    if (colorCount[color] == null) {
                        colorCount[color] = 1;
                    } else {
                        colorCount[color]++;
                    }

                    if (colorCount[color] > highestCount || (colorCount[color] == highestCount && color > mostCommonColor)) {
                        mostCommonColor = color;
                        highestCount = colorCount[color];
                    }
                }
            }
        }
        return mostCommonColor;
    }

    public static function lineOfSight(bitmap:BitmapData, start:Point, end:Point):Boolean {
        var dx:int = Math.abs(end.x - start.x);
        var dy:int = Math.abs(end.y - start.y);
        var sx:int = (start.x < end.x) ? 1 : -1;
        var sy:int = (start.y < end.y) ? 1 : -1;
        var err:int = dx - dy;

        var x:int = start.x;
        var y:int = start.y;

        while (true) {
            if (x < 0 || x >= bitmap.width || y < 0 || y >= bitmap.height) {
                return false;
            }
            if (bitmap.getPixel(x, y) == 0) {
                return false;
            }
            if (x == end.x && y == end.y) {
                break;
            }
            var e2:int = err * 2;
            if (e2 > -dy) {
                err -= dy;
                x += sx;
            }
            if (e2 < dx) {
                err += dx;
                y += sy;
            }
        }
        return true;
    }
}
}
