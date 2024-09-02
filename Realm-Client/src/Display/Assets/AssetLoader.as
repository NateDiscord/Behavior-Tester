package Display.Assets
{
import Display.Control.AssetLibrary;
import Display.Control.ObjectLibrary;

public class AssetLoader
{
    public function AssetLoader()
    {
        super();
    }

    public function load() : void
    {
        this.addImages();
        this.parseObjectFiles();
    }

    private function addImages() : void
    {
        AssetLibrary.addImageSet("lofiObj",new EmbeddedAssets.lofiObjEmbed_().bitmapData,8,8);
        AssetLibrary.addImageSet("lofiObj2",new EmbeddedAssets.lofiObj2Embed_().bitmapData,8,8);
        AssetLibrary.addImageSet("lofiObj5",new EmbeddedAssets.lofiObj5Embed_().bitmapData,8,8);
        AssetLibrary.addImageSet("lofiObjBig",new EmbeddedAssets.lofiObjBigEmbed_().bitmapData,16,16);
    }

    private function parseObjectFiles() : void
    {
        var objectObj:* = undefined;
        for each(objectObj in EmbeddedData.objectFiles)
        {
            ObjectLibrary.parseFromXML(XML(objectObj));
        }
    }
}
}