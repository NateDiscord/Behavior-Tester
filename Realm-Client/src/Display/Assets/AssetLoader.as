package Display.Assets
{
import Display.Control.AssetLibrary;

public class AssetLoader
{
    public function AssetLoader()
    {
        super();
    }

    public function load() : void
    {
        this.addImages();
    }

    private function addImages() : void
    {
        AssetLibrary.addImageSet("lofiObj5",new EmbeddedAssets.lofiObj5Embed_().bitmapData,8,8);
    }
}
}