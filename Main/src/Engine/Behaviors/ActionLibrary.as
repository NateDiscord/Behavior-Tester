package Engine.Behaviors {
import Engine.Behaviors.Actions.ShootAction;
import Engine.Behaviors.Actions.WanderAction;
import Engine.Behaviors.Modals.Wander;
import Engine.Behaviors.Modals.Shoot;

public class ActionLibrary {
    public static const ACTION_MODEL_MAP:Object = {
        "shoot": Shoot,
        "wander": Wander
    };

    public static const ACTION_MAP:Object = {
        "shoot": ShootAction,
        "wander": WanderAction
    };

    public static function Create(actionType:String, attributes:Object):Object {
        var classRef:Class = ACTION_MODEL_MAP[actionType];
        if (classRef) {
            var instance:Object = new classRef();
            instance.action = actionType;
            for (var key:String in attributes) {
                if (instance.hasOwnProperty(key)) {
                    var value:String = attributes[key];
                    var propertyType:String = typeof(instance[key]);
                    switch (propertyType) {
                        case "number":
                            var numValue:Number = parseFloat(value);
                            if (!isNaN(numValue)) {
                                instance[key] = numValue;
                            }
                            break;
                        case "int":
                            var intValue:int = parseInt(value);
                            instance[key] = intValue;
                            break;
                        case "string":
                            instance[key] = value;
                            break;
                        default:
                            trace("Unsupported property type: " + propertyType);
                            break;
                    }
                }
            }

            return instance;
        } else {
            throw new Error("Unknown action type: " + actionType);
        }
    }
}
}
