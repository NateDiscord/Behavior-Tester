package Engine.Behaviors.Actions {
import Display.Assets.Objects.Entity;

import Engine.Behaviors.Modals.Shoot;

import Modules.Projectile;

import flash.utils.getTimer;

public class ShootAction extends Action
{
    private var action:Shoot;

    public function ShootAction(entity:Entity, action:Shoot)
    {
        super(entity);
        this.action = action;
    }

    public override function update() : void
    {
        if (this.entity == null)
            return;

        this.updateTime();
        if (this.elapsedTime > action.coolDown) {
            resetTime();
            return;
        }

        if (this.elapsedTime >= action.coolDownOffset && this.cycle) {
            for (var i:int = 0; i < action.shots; i++) {
                if (!this.entity.isVisible)
                    continue;
                var angle:Number = action.fixedAngle + (action.angle * i);
                var projectile:Projectile = new Projectile(this.entity.map_, this.entity, this.entity.projectiles_[action.projectileIndex], angle * (Math.PI / 180), getTimer());
                this.entity.map_.addObj(projectile);
            }
            this.cycle = false;
        }
    }
}
}
