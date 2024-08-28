package Display.Control {
import Display.Util.ImageSet;

import flash.display.BitmapData;
import flash.utils.Dictionary;

public class AssetLibrary {
    private static var images_:Dictionary = new Dictionary();
    private static var imageSets_:Dictionary = new Dictionary();
    private static var imageLookup_:Dictionary = new Dictionary();

    public function AssetLibrary() {
    }

    public static function addImageSet(imageId:String, bitmapData:BitmapData, width:int, height:int):void {
        images_[imageId] = bitmapData;
        var imageSet:ImageSet = new ImageSet();
        imageSet.addFromBitmapData(bitmapData, width, height);
        imageSets_[imageId] = imageSet;
        var _local6:int = 0;
        while (_local6 < imageSet.images.length) {
            imageLookup_[imageSet.images[_local6]] = [imageId, _local6];
            _local6++;
        }
    }

    public static function addToImageSet(imageId:String, bitmapData:BitmapData):void {
        var imageSet:ImageSet = imageSets_[imageId];
        if (imageSet == null) {
            imageSet = new ImageSet();
            imageSets_[imageId] = imageSet;
        }
        imageSet.add(bitmapData);
        var _local4:int = (imageSet.images.length - 1);
        imageLookup_[imageSet.images[_local4]] = [imageId, _local4];
    }

    public static function getImage(imageId:String):BitmapData {
        return (images_[imageId]);
    }

    public static function getImageSet(imageId:String):ImageSet {
        return (imageSets_[imageId]);
    }

    public static function getImageFromSet(file:String, index:int):BitmapData {
        var _local3:ImageSet = imageSets_[file];
        return (_local3.images[index]);
    }
}
}

