package Display.Assets {
import Resources.XML.*;

public class EmbeddedData {
    public function EmbeddedData()
    {
        super();
    }

    private static const ProjectilesCXML:Class = EmbeddedData_ProjectilesCXML;
    private static const EquipCXML:Class = EmbeddedData_EquipCXML;
    private static const EncountersCXML:Class = EmbeddedData_EncountersCXML;
    private static const GroundCXML:Class = EmbeddedData_GroundCXML;

    public static const objectFiles:Array = [new ProjectilesCXML(), new EquipCXML(), new EncountersCXML()];
}
}