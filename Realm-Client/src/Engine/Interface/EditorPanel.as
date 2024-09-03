package Engine.Interface {
import Display.Control.ObjectLibrary;
import Display.Control.Redrawers.TextureRedrawer;
import Display.Text.SimpleText;
import Display.Util.FilterUtil;
import Display.Util.GraphicsUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

public class EditorPanel extends Sprite {

    private var host:Interface;

    private var headerText:SimpleText;
    private var container:Sprite;
    private var inset:Sprite;
    private var offset:Point;

    private var enemyBitmap:Bitmap;
    private var enemyName:SimpleText;
    private var enemyHealth:SimpleText;

    public var hasBeenMoved:Boolean = false;

    public function EditorPanel(host:Interface) {
        this.host = host;

        this.offset = new Point();
        this.x = Math.max(5, Math.min(this.x, Main.windowWidth - this.width - 5));
        this.y = Math.max(5, Math.min(this.y, Main.windowHeight - this.height - 5));

        this.addGraphics();
        this.addHeader();
        this.enableDragging();
        this.rePosition();
    }

    private function addGraphics():void {
        this.container = new Sprite();
        this.inset = new Sprite();

        this.container = GraphicsUtil.drawBackground(200, 550, 12);
        addChild(this.container);

        this.inset = GraphicsUtil.drawInset(190, 510, 10);
        this.inset.x = 5;
        this.inset.y = 35;
        this.container.addChild(this.inset);
    }

    private function addHeader():void {
        this.headerText = new SimpleText(20, 0xFFFFFF);
        this.handleText(this.headerText, "Behavior Editor", this);

        var bd:BitmapData = ObjectLibrary.getRedrawnTextureFromType(Main.CURRENT_ENTITY.objectType);
        var check:Boolean = bd.width > 8;
        bd = TextureRedrawer.redraw(bd, check ? 40 : 80, false, 0);
        this.enemyBitmap = new Bitmap(bd);
        this.enemyBitmap.x = 5;
        this.enemyBitmap.y = 5;
        this.inset.addChild(this.enemyBitmap);

        this.enemyName = new SimpleText(14, 0xffffff, false);
        this.handleText(this.enemyName, ObjectLibrary.getIdFromType(Main.CURRENT_ENTITY.objectType), this.inset);

        this.enemyHealth = new SimpleText(11, 0xaaaaaa, false);
        this.handleText(this.enemyHealth, Main.CURRENT_ENTITY.xml_.MaxHitPoints + " HP", this.inset);
    }

    private function rePosition():void
    {
        this.headerText.x = 100 - this.headerText.width / 2;
        this.headerText.y = 5;

        this.enemyName.x = this.enemyBitmap.width;
        this.enemyName.y = this.enemyBitmap.x + (this.enemyBitmap.height / 2 - this.enemyName.height / 2) - 2;

        this.enemyHealth.x = this.enemyName.x;
        this.enemyHealth.y = this.enemyName.y + this.enemyName.height - 3;
    }

    private function enableDragging():void {
        addEventListener("mouseDown", startDragPanel);
    }

    private function startDragPanel(event:MouseEvent):void {
        this.offset.x = event.stageX - this.x;
        this.offset.y = event.stageY - this.y;

        stage.addEventListener("mouseMove", dragPanel);
        stage.addEventListener("mouseUp", stopDragPanel);
    }

    private function dragPanel(event:MouseEvent):void {
        this.x = event.stageX - this.offset.x;
        this.y = event.stageY - this.offset.y;

        this.x = Math.max(5, Math.min(this.x, Main.windowWidth - this.width - 5));
        this.y = Math.max(5, Math.min(this.y, Main.windowHeight - this.height - 5));
        event.updateAfterEvent();

        if (!hasBeenMoved)
            hasBeenMoved = true;
    }

    private function stopDragPanel(event:MouseEvent):void {
        stage.removeEventListener("mouseMove", dragPanel);
        stage.removeEventListener("mouseUp", stopDragPanel);
    }

    private function handleText(text:SimpleText, content:String, target:Sprite):void {
        text.setBold(true);
        text.filters = FilterUtil.getTextOutlineFilter();
        text.autoSize = "left";
        text.htmlText = content;
        target.addChild(text);
    }

}
}
