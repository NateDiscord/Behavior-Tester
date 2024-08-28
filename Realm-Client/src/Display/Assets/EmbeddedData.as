package Display.Assets {
import Resources.XML.EmbeddedData_EquipCXML;

public class EmbeddedData {
    public function EmbeddedData()
    {
        super();
    }

    private static const EquipCXML:Class = EmbeddedData_EquipCXML;

    public static const objectFiles:Array = [new EquipCXML()];
}
}