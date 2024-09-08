package Engine.Behaviors.Actions {
import Display.Assets.Objects.Entity;

import Engine.Behaviors.Modals.Shoot;

import Modules.Projectile;

import flash.utils.getTimer;

public class ShootAction extends Action
{
    private var host:Entity;
    private var action:Shoot;

    public function ShootAction(host:Entity, action:Shoot)
    {
        this.host = host;
        this.action = action;
    }

    public override function update() : void
    {
        if (this.host == null)
            return;

        this.updateTime();
        if (this.elapsedTime > action.coolDown)
        {
            resetTime();
            return;
        }
        if (this.elapsedTime >= action.coolDownOffset && this.cycle) {
            for (var i:int = 0; i < action.shots; i++) {
                var angle:Number = action.fixedAngle + (action.angle * i);
                var projectile:Projectile = new Projectile(host.map_, host, host.projectiles_[action.projectileIndex], angle * (Math.PI / 180), getTimer());
                host.map_.addObj(projectile);
            }
            this.cycle = false;
        }
    }
}
}
