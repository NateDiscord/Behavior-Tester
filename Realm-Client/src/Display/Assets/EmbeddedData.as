package Display.Assets {
import Resources.XML.EmbeddedData_EncountersCXML;
import Resources.XML.EmbeddedData_EquipCXML;

public class EmbeddedData {
    public function EmbeddedData()
    {
        super();
    }

    private static const EquipCXML:Class = EmbeddedData_EquipCXML;
    private static const EncountersCXML:Class = EmbeddedData_EncountersCXML;

    public static const objectFiles:Array = [new EquipCXML(), new EncountersCXML()];
}
}