package Engine.Interface {
import Display.Assets.Elements.Scrollbar;
import Display.Assets.Objects.Entity;
import Display.Control.ObjectLibrary;
import Display.Control.Redrawers.TextureRedrawer;
import Display.Text.SimpleText;
import Display.Util.ColorUtil;
import Display.Util.FilterUtil;
import Display.Util.GraphicsUtil;
import Display.Util.TextUtil;

import Engine.Behaviors.Modals.BehaviorDb;

import Engine.File.Parameters;
import Engine.Interface.Editor.States.StateCell;

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

public class Editor extends Sprite {

    public static const PANEL_WIDTH:int = 400;
    public static const INSET_WIDTH:int = 390;

    public static const PANEL_HEIGHT:int = 700;
    public static const INSET_HEIGHT:int = 675;

    private var container:Sprite;
    private var inset:Sprite;

    private var scrollBar:Scrollbar;
    public var stateCells:Vector.<StateCell>;

    private var enemyBitmap:Bitmap;
    private var enemyName:SimpleText;
    private var editorBounds:Sprite;
    private var editorMask:Sprite;

    public var interface_:Interface;
    private var offset:Point;
    public var hasBeenMoved:Boolean = false;

    public function Editor(host:Interface) {
        this.interface_ = host;

        this.offset = new Point();
        this.x = Math.max(5, Math.min(this.x, Main.STAGE.stageWidth - this.width - 5));
        this.y = Math.max(5, Math.min(this.y, Main.STAGE.stageHeight - this.height - 5));

        this.addGraphics();
        this.addHeader();
        this.addContent();
        this.enableDragging();
        this.rePosition();
    }

    private function addGraphics():void {
        this.container = new Sprite();
        this.inset = new Sprite();

        this.container = GraphicsUtil.drawTransparentWindow(PANEL_WIDTH, 30, ColorUtil.EDITOR_HEADER_COLOR, 0.9);
        addChild(this.container);

        this.inset = GraphicsUtil.drawTransparentWindow(PANEL_WIDTH, PANEL_HEIGHT - 30, ColorUtil.EDITOR_COLOR, 0.9);
        this.inset.y = 30;
        this.container.addChild(this.inset);

        this.filters = FilterUtil.getEditorOutlineFilter();
    }

    private function addHeader():void {
        var en:Vector.<Entity> = Parameters.data_["entities"];
        var bd:BitmapData = ObjectLibrary.getRedrawnTextureFromType(en[0].objectType);
        bd = TextureRedrawer.redraw(bd, 20, false, 0);
        this.enemyBitmap = new Bitmap(bd);
        addChild(this.enemyBitmap);

        this.enemyName = new SimpleText(14, 0xffffff, false);
        TextUtil.handleText(this.enemyName, ObjectLibrary.getIdFromType(en[0].objectType), this);

        this.editorBounds = new Sprite();
        this.editorMask = setBounds();
        this.editorBounds.y = 5;
        this.editorBounds.mask = this.editorMask;
        this.inset.addChild(this.editorBounds);
        this.inset.addChild(this.editorMask);
    }

    private function setBounds():Sprite {
        var s:Sprite = new Sprite();
        var g:Graphics = s.graphics;
        g.clear();
        g.beginFill(0, 0);
        g.drawRect(0, 0, INSET_WIDTH, INSET_HEIGHT - 35);
        g.endFill();
        return s;
    }

    private function addContent():void
    {
        this.stateCells = new Vector.<StateCell>();
        var behav:BehaviorDb = Parameters.data_["targetBehavior"];
        var len:int = behav.statesList_.length;
        for (var i:int = 0; i < len; i++)
        {
            this.stateCells[i] = new StateCell(i, this);
            this.editorBounds.addChild(this.stateCells[i]);
            this.stateCells.push(this.stateCells[i]);
        }
    }

    public function rePosition():void
    {
        this.enemyBitmap.x = -6;
        this.enemyBitmap.y = -6;

        this.enemyName.x = this.enemyBitmap.width - 12;
        this.enemyName.y = 5;

        var len:int = this.stateCells.length - 1;
        for (var i:int = 0; i < len; i++)
        {
            this.stateCells[i].x = 5;
            if (i == 0)
                this.stateCells[i].y = 5;
            else
                this.stateCells[i].y = 5 + (this.stateCells[i - 1].height * i);
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
        var offset:int = 5;
        this.editorBounds.y = offset - (this.scrollBar.pos() * (this.editorBounds.height - this.editorMask.height));
    }

    public function resize():void
    {
        var scale:Number = Main.STAGE.stageHeight / 720;
        this.scaleX = this.scaleY = scale > 1 ? 1 : scale;
        if (!this.hasBeenMoved)
            this.y = (Main.STAGE.stageHeight - this.height) / 2;
        this.x = Math.max(5, Math.min(this.x, Main.STAGE.stageWidth - this.width - 5));
        this.y = Math.max(5, Math.min(this.y, Main.STAGE.stageHeight - this.height - 5));
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

        this.x = Math.max(5, Math.min(this.x, Main.STAGE.stageWidth - this.width - 5));
        this.y = Math.max(5, Math.min(this.y, Main.STAGE.stageHeight - this.height - 5));
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
