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
        AssetLibrary.addImageSet("lofiObj5",new EmbeddedAssets.lofiObj5Embed_().bitmapData,8,8);
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