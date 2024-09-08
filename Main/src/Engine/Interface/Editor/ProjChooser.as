package Engine.Interface.Editor {
import Display.Assets.Objects.Entity;
import Display.Control.ObjectLibrary;
import Display.Util.FilterUtil;

import Engine.Behaviors.Modals.BehaviorDb;
import Engine.Behaviors.Modals.Shoot;

import Engine.File.Parameters;
import Engine.Interface.Editor.Behaviors.BehaviorCell;

import Modules.ProjectileProperties;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class ProjChooser extends Sprite {

    private var projectiles:Vector.<ProjectileProperties>;
    private var bitmaps:Vector.<Bitmap>;

    private var host:BehaviorCell;
    private var container:Sprite;

    public function ProjChooser(host:BehaviorCell) {
        this.host = host;
        addProjectiles();
        addBackground();
        addBitmaps();
    }

    private function addProjectiles():void
    {
        var entities:Vector.<Entity> = Parameters.data_["entities"];
        var en:Entity = entities[0];

        var h:int = 0;
        this.projectiles = new Vector.<ProjectileProperties>();
        for each (var proj:ProjectileProperties in en.projectiles_)
        {
            this.projectiles[h] = proj;
            h++;
        }
    }

    private function addBackground():void
    {
        var length:int = this.projectiles.length;
        graphics.clear();
        graphics.beginFill(0x151515);
        graphics.drawRoundRect(0,0, 4 + (length * 25), 24, 10, 10);
        graphics.endFill();

        this.container = new Sprite();
        this.container.mouseChildren = true;
        addChild(this.container);
    }

    private function addBitmaps():void {
        this.bitmaps = new Vector.<Bitmap>();
        var behav:BehaviorDb = Parameters.data_["targetBehavior"];
        var shoot:Shoot = behav.statesList_[this.host.host.index].actions_[this.host.index];

        for (var i:int = 0; i < this.projectiles.length; i++) {
            var objectType:int = ObjectLibrary.idToType_[this.projectiles[i].objectId_];
            var bd:BitmapData = ObjectLibrary.getRedrawnTextureFromType(objectType);
            var filter:Array = i == shoot.projectileIndex ? FilterUtil.getWhiteOutlineFilter() : FilterUtil.getTextOutlineFilter();

            var s:Sprite = new Sprite();
            addChild(s);

            var bitmap:Bitmap = new Bitmap(bd);
            bitmap.scaleX = bitmap.scaleY = 2;
            bitmap.filters = filter;

            s.x = 4 + 25 * i;
            s.y = 6;
            s.addChild(bitmap);
            s.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
                changeIndex(i);
            });

            this.bitmaps.push(bitmap);
            this.container.addChild(s);
        }
    }


    private function changeIndex(value:int):void {

        var behav:BehaviorDb = Parameters.data_["targetBehavior"];
        var shoot:Shoot = behav.statesList_[this.host.host.index].actions_[this.host.index];
        if (shoot == null)
            return;

        shoot.projectileIndex = value;
        behav.statesList_[this.host.host.index].actions_[this.host.index] = shoot;

        for (var i:int = 0; i < this.projectiles.length; i++)
        {
            var filter:Array = i == value ? FilterUtil.getWhiteOutlineFilter() : FilterUtil.getTextOutlineFilter();
            this.bitmaps[i].filters = filter;
        }
    }
}
}
