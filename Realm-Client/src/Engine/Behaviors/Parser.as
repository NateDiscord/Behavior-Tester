package Engine.Behaviors {
import Engine.Behaviors.Modals.BehaviorDb;
import Engine.Behaviors.Modals.Shoot;
import Engine.Behaviors.Modals.State;

public class Parser {
    public static function ParseData(content:String):BehaviorDb {
        // Remove leading and trailing spaces and newlines
        content = content.replace(/^\s+|\s+$/g, '');

        // Regex patterns for parsing
        var entityPattern:RegExp = /\[entity="([^"]+)"\]/;
        var statePattern:RegExp = /\[state="([^"]+)"\]\s*\{([^}]*)\}/g;
        var actionPattern:RegExp = /\[action="(\w+)"(?:,\s*(\w+)="([^"]+)")?(?:,\s*(\w+)="([^"]+)")?(?:,\s*(\w+)="([^"]+)")?\]/g;

        // Extract entity
        var entityMatch:Array = entityPattern.exec(content);
        var behaviorDb:BehaviorDb = new BehaviorDb();

        if (entityMatch) {
            behaviorDb.name_ = entityMatch[1];
        }

        // Extract states and actions
        var states:Array = [];
        var stateMatch:Array;

        while ((stateMatch = statePattern.exec(content)) != null) {
            var stateName:String = stateMatch[1];
            var actionsContent:String = stateMatch[2];

            var state:State = new State();
            state.id_ = stateName;

            // Extract actions for this state
            var actions:Array = [];
            var actionMatch:Array;
            while ((actionMatch = actionPattern.exec(actionsContent)) != null) {
                var actionType:String = actionMatch[1];
                var attributes:Object = {};

                // Collect attributes
                if (actionMatch[2]) attributes[actionMatch[2]] = actionMatch[3];
                if (actionMatch[4]) attributes[actionMatch[4]] = actionMatch[5];
                if (actionMatch[6]) attributes[actionMatch[6]] = actionMatch[7];

                // Use a switch statement to handle different action types
                var action:Shoot; // Assume Action is a base class for different actions
                switch (actionType) {
                    case "shoot":
                        var shoot:Shoot = new Shoot();
                        if ("angle" in attributes) {
                            shoot.angle = parseInt(attributes["angle"]);
                        }
                        if ("coolDown" in attributes) {
                            shoot.coolDown = parseInt(attributes["coolDown"]);
                        }
                        if ("coolDownOffset" in attributes) {
                            shoot.coolDownOffset = parseInt(attributes["coolDownOffset"]);
                        }
                        action = shoot;
                        break;
                        // Add additional cases for other action types
                    default:
                        throw new Error("Unknown action type: " + actionType);
                }

                actions.push(action);
            }

            state.actions_ = actions;
            states.push(state);
        }

        behaviorDb.statesList_ = states;
        return behaviorDb;
    }
}
}