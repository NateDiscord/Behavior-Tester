package Engine.Behaviors.Actions {
import Display.Assets.Objects.Entity;

import Engine.Behaviors.Actions.Utils.WanderStorage;

import Engine.Behaviors.Modals.Wander;

public class WanderAction extends Action
{
    private var host:Entity;
    private var action:Wander;
    private var wanderStorage:WanderStorage;

    public function WanderAction(host:Entity, action:Wander)
    {
        this.host = host;
        this.action = action;
        this.wanderStorage = new WanderStorage();
    }

    public override function update() : void
    {
        if (this.host == null)
            return;

        this.updateTime();
        if (this.elapsedTime > 1000)
        {
            this.resetTime();
            return;
        }

        if (this.wanderStorage.remainingDistance <= 0)
        {
            this.wanderStorage.direction.x = Math.random() < 0.5 ? -1 : 1;
            this.wanderStorage.direction.y = Math.random() < 0.5 ? -1 : 1;
            this.wanderStorage.direction.normalize(1);
            this.wanderStorage.remainingDistance = 600 / 1000;
        }
        var dist:Number = this.action.speed * (this.elapsedTime / 1000);
        this.host.x += this.wanderStorage.direction.x * dist;
        this.host.y += this.wanderStorage.direction.y * dist;
        this.wanderStorage.remainingDistance -= dist;

    }
}
}