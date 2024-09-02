package Display.Control.Redrawers {
import Display.Control.*;
import Display.Util.PointUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.GradientType;
import flash.display.Shape;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.utils.Dictionary;

public class GlowRedrawer {
    private static const GRADIENT_MAX_SUB:uint = 0x282828;
    private static const GLOW_FILTER:GlowFilter = new GlowFilter(0, 0.3, 12, 12, 2, BitmapFilterQuality.LOW, false, false);

    private static var tempMatrix:Matrix = new Matrix();
    private static var gradient:Shape = createGradient();
    private static var glowCache:Dictionary = new Dictionary();

    public static function outlineGlow(sourceBitmapData:BitmapData, color:uint, blur:Number = 1.4, cacheResult:Boolean = true):BitmapData {
        var cacheKey:String = createCacheKey(color, blur);
        if (cacheResult && isCached(sourceBitmapData, cacheKey)) {
            return glowCache[sourceBitmapData][cacheKey];
        }

        var resultBitmapData:BitmapData = sourceBitmapData.clone();
        tempMatrix.identity();
        tempMatrix.scale(sourceBitmapData.width / 0x0100, sourceBitmapData.height / 0x0100);
        resultBitmapData.draw(gradient, tempMatrix, null, BlendMode.SUBTRACT);

        var bitmap:Bitmap = new Bitmap(sourceBitmapData);
        resultBitmapData.draw(bitmap, null, null, BlendMode.ALPHA);

        TextureRedrawer.OUTLINE_FILTER.blurX = blur;
        TextureRedrawer.OUTLINE_FILTER.blurY = blur;
        TextureRedrawer.OUTLINE_FILTER.color = 0xFFFFFF;
        resultBitmapData.applyFilter(resultBitmapData, resultBitmapData.rect, PointUtil.ORIGIN, TextureRedrawer.OUTLINE_FILTER);

        if (color != 0xFFFFFFFF) {
            GLOW_FILTER.color = color;
            resultBitmapData.applyFilter(resultBitmapData, resultBitmapData.rect, PointUtil.ORIGIN, GLOW_FILTER);
        }

        if (cacheResult) {
            cache(sourceBitmapData, color, blur, resultBitmapData);
        }

        return resultBitmapData;
    }

    public static function glow(sourceBitmapData:BitmapData, color:uint, blur:Number = 1.4, cacheResult:Boolean = false):BitmapData {
        var cacheKey:String = createCacheKey(color, blur);
        if (cacheResult && isCached(sourceBitmapData, cacheKey)) {
            return glowCache[sourceBitmapData][cacheKey];
        }

        var resultBitmapData:BitmapData = sourceBitmapData.clone();
        tempMatrix.identity();
        tempMatrix.scale(sourceBitmapData.width / 0x0100, sourceBitmapData.height / 0x0100);
        resultBitmapData.draw(gradient, tempMatrix, null, BlendMode.SUBTRACT);

        var bitmap:Bitmap = new Bitmap(sourceBitmapData);
        resultBitmapData.draw(bitmap, null, null, BlendMode.ALPHA);

        if (color != 0xFFFFFFFF) {
            GLOW_FILTER.color = color;
            resultBitmapData.applyFilter(resultBitmapData, resultBitmapData.rect, PointUtil.ORIGIN, GLOW_FILTER);
        }

        if (cacheResult) {
            cache(sourceBitmapData, color, blur, resultBitmapData);
        }

        return resultBitmapData;
    }

    private static function cache(sourceBitmapData:BitmapData, color:uint, blur:Number, resultBitmapData:BitmapData):void {
        var cacheKey:String = createCacheKey(color, blur);
        if (sourceBitmapData in glowCache) {
            glowCache[sourceBitmapData][cacheKey] = resultBitmapData;
        } else {
            var newCache:Object = {};
            newCache[cacheKey] = resultBitmapData;
            glowCache[sourceBitmapData] = newCache;
        }
    }

    private static function isCached(sourceBitmapData:BitmapData, cacheKey:String):Boolean {
        var cache:Object = glowCache[sourceBitmapData];
        return cache != null && cacheKey in cache;
    }

    private static function createCacheKey(color:uint, blur:Number):String {
        return int(blur * 10).toString() + color;
    }

    private static function createGradient():Shape {
        var shape:Shape = new Shape();
        var matrix:Matrix = new Matrix();
        matrix.createGradientBox(0x0100, 0x0100, Math.PI / 2, 0, 0);
        shape.graphics.beginGradientFill(GradientType.LINEAR, [0, GRADIENT_MAX_SUB], [1, 1], [127, 255], matrix);
        shape.graphics.drawRect(0, 0, 0x0100, 0x0100);
        shape.graphics.endFill();
        return shape;
    }
}
}
