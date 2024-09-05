package Engine.Interface.Editor {
import Display.Assets.Elements.Scrollbar;
import Display.Control.ObjectLibrary;
import Display.Control.Redrawers.TextureRedrawer;
import Display.Text.SimpleText;
import Display.Util.FilterUtil;
import Display.Util.GraphicsUtil;
import Display.Util.TextUtil;

import Engine.File.Parameters;

import Engine.Interface.Interface;

import flash.events.Event;

import flash.geom.Rectangle;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Graphics;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

public class EditorPanel extends Sprite {

    public static const PANEL_WIDTH:int = 400;
    public static const INSET_WIDTH:int = 390;

    public static const PANEL_HEIGHT:int = 700;
    public static const INSET_HEIGHT:int = 660;

    private var container:Sprite;
    private var inset:Sprite;

    private var headerText:SimpleText;
    private var lineBreak:Sprite;
    private var lineBreakTwo:Sprite;
    private var scrollBar:Scrollbar;
    public var stateCells:Vector.<StateCell>;

    private var enemyBitmap:Bitmap;
    private var enemyName:SimpleText;
    private var enemyHealth:SimpleText;
    private var editorBounds:Sprite;
    private var editorMask:Sprite;

    private var host:Interface;
    private var offset:Point;
    public var hasBeenMoved:Boolean = false;

    public function EditorPanel(host:Interface) {
        this.host = host;

        this.offset = new Point();
        this.x = Math.max(5, Math.min(this.x, Main.windowWidth - this.width - 5));
        this.y = Math.max(5, Math.min(this.y, Main.windowHeight - this.height - 5));

        this.addGraphics();
        this.addHeader();
        this.addContent();
        this.enableDragging();
        this.rePosition();
    }

    private function addGraphics():void {
        this.container = new Sprite();
        this.inset = new Sprite();

        this.container = GraphicsUtil.drawBackground(PANEL_WIDTH, PANEL_HEIGHT, 12);
        addChild(this.container);

        this.inset = GraphicsUtil.drawInset(INSET_WIDTH, INSET_HEIGHT, 10);
        this.inset.x = 5;
        this.inset.y = 35;
        this.container.addChild(this.inset);
    }

    private function addHeader():void {
        this.headerText = new SimpleText(20, 0xFFFFFF);
        TextUtil.handleText(this.headerText, "Behavior Editor", this);

        var bd:BitmapData = ObjectLibrary.getRedrawnTextureFromType(Main.CURRENT_ENTITY.objectType);
        var check:Boolean = bd.width > 8;
        bd = TextureRedrawer.redraw(bd, check ? 40 : 80, false, 0);
        this.enemyBitmap = new Bitmap(bd);
        this.enemyBitmap.x = 5;
        this.enemyBitmap.y = 5;
        this.inset.addChild(this.enemyBitmap);

        this.enemyName = new SimpleText(16, 0xffffff, false);
        TextUtil.handleText(this.enemyName, ObjectLibrary.getIdFromType(Main.CURRENT_ENTITY.objectType), this.inset);

        this.enemyHealth = new SimpleText(12, 0xaaaaaa, false);
        TextUtil.handleText(this.enemyHealth, Main.CURRENT_ENTITY.xml_.MaxHitPoints + " HP", this.inset);

        this.lineBreak = addLineBreak();
        this.lineBreak.x = 5;
        this.lineBreak.y = this.enemyBitmap.y + this.enemyBitmap.height + 10;
        this.inset.addChild(this.lineBreak);

        this.editorBounds = new Sprite();
        this.editorMask = setBounds();
        this.editorBounds.y = this.editorMask.y = this.lineBreak.y + 5;
        this.editorBounds.mask = this.editorMask;
        this.inset.addChild(this.editorBounds);
        this.inset.addChild(this.editorMask);

        this.lineBreakTwo = addLineBreak();
        this.lineBreakTwo.x = 5;
        this.lineBreakTwo.y = this.editorMask.y + this.editorMask.height + 5;
        this.inset.addChild(this.lineBreakTwo);
    }

    private function setBounds():Sprite {
        var s:Sprite = new Sprite();
        var g:Graphics = s.graphics;
        g.clear();
        g.beginFill(0, 0);
        g.drawRect(0, 0, INSET_WIDTH, INSET_HEIGHT - (this.lineBreak.y + 5) - 20);
        g.endFill();
        return s;
    }

    private function addLineBreak():Sprite {
        var s:Sprite = new Sprite();
        var g:Graphics = s.graphics;
        g.clear();
        g.lineStyle(2, 0x505050);
        g.beginFill(0, 0);
        g.drawRoundRect(0, 0, INSET_WIDTH - 10, 1, 5, 5);
        return s;
    }

    private function addContent():void
    {
        this.stateCells = new Vector.<StateCell>();
        var len:int = Main.CURRENT_BEHAVIOR.statesList_.length;
        for (var i:int = 0; i < len; i++)
        {
            this.stateCells[i] = new StateCell(i, this);
            this.editorBounds.addChild(this.stateCells[i]);
            this.stateCells.push(this.stateCells[i]);
        }
    }

    public function rePosition():void
    {
        this.headerText.x = PANEL_WIDTH / 2 - this.headerText.width / 2;
        this.headerText.y = 5;

        this.enemyName.x = this.enemyBitmap.width;
        this.enemyName.y = this.enemyBitmap.x + (this.enemyBitmap.height / 2 - this.enemyName.height / 2) - 2;

        this.enemyHealth.x = this.enemyName.x;
        this.enemyHealth.y = this.enemyName.y + this.enemyName.height - 3;

        var len:int = this.stateCells.length - 1;
        for (var i:int = 0; i < len; i++)
        {
            this.stateCells[i].x = 5;
            if (i == 0)
                this.stateCells[i].y = 5;
            else
                this.stateCells[i].y = 5 + (this.stateCells[i - 1].height * i) + (5 * i);
        }

        if (this.scrollBar)
            if (this.stateCells[len].y < 400)
            {
                this.inset.removeChild(this.scrollBar);
                this.scrollBar = null;
            }

        if (!this.scrollBar)
            if (this.stateCells[len].y > 400)
            {
                this.scrollBar = new Scrollbar(6, 563);
                this.scrollBar.setIndicatorSize(this.editorMask.height, this.editorBounds.height);
                this.scrollBar.x = INSET_WIDTH - this.scrollBar.width - 3;
                this.scrollBar.y = this.editorMask.y + 5;
                this.scrollBar.addEventListener("change", onScrollBarChange);
                this.inset.addChild(this.scrollBar);
            }
    }

    private function onScrollBarChange(event:Event) : void
    {
        var offset:int = this.lineBreak.y + 3;
        this.editorBounds.y = offset - (this.scrollBar.pos() * (this.editorBounds.height - this.editorMask.height));
    }

    private function enableDragging():void {
        addEventListener("mouseDown", startDragPanel);
    }

    private function startDragPanel(event:MouseEvent):void {
        if (Parameters.data_["scrolling"])
            return;
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

}
}
