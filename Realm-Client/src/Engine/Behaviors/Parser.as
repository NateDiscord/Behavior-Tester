package Engine.Behaviors {
import Engine.Behaviors.Modals.BehaviorDb;
import Engine.Behaviors.Modals.Shoot;
import Engine.Behaviors.Modals.State;

public class Parser {
    public static function ParseData(content:String) : BehaviorDb {
        // Remove leading and trailing spaces and newlines
        content = content.replace(/^\s+|\s+$/g, '');

        // Regex patterns for parsing
        var entityPattern:RegExp = /\[entity="([^"]+)"\]/;
        var statePattern:RegExp = /\[state="([^"]+)"\]\s*\{([^}]*)\}/g;
        var actionPattern:RegExp = /\[(\w+),\s*angle="([^"]+)",\s*coolDown="([^"]+)"\]/g;

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
                var angle:int = parseInt(actionMatch[2]);
                var coolDown:int = parseInt(actionMatch[3]);

                if (actionType == "shoot") {
                    var shoot:Shoot = new Shoot();
                    shoot.angle = angle;
                    shoot.coolDown = coolDown;
                    actions.push(shoot);
                }
            }

            state.actions_ = actions;
            states.push(state);
        }

        behaviorDb.statesList_ = states;
        return behaviorDb;
    }
}
}
