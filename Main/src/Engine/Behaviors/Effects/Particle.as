package Engine.Behaviors.Effects {
import Display.Assets.Objects.BasicObject;
import Display.Control.Redrawers.TextureRedrawer;
import Display.Util.GraphicsUtil;

import Engine.Camera;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;

import flash.display.IGraphicsData;
import flash.geom.Matrix;

public class Particle
{
    protected var bitmapFill_:GraphicsBitmapFill = new GraphicsBitmapFill(null,null,false,false);
    protected var path_:GraphicsPath = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS,null);
    protected var vS_:Vector.<Number>= new Vector.<Number>();
    protected var fillMatrix_:Matrix= new Matrix();

    public var posS_:Vector.<Number>;

    public var size_:int;
    public var color_:uint;

    private var texture_:BitmapData;
    private var tW_:int;
    private var tH_:int;

    public function Particle(color:uint, z:Number, size:int)
    {
        this.color_ = color;
        setSize(size);
    }

    public function setColor(color:uint) : void
    {
        this.color_ = color;
        updateTexture();
    }

    public function setSize(size:int) : void
    {
        this.size_ = size / 100 * 5;
        updateTexture();
    }

    private function updateTexture() : void
    {
        this.texture_ = TextureRedrawer.redrawSolidSquare(this.color_,this.size_);
        this.tW_ = this.texture_.width / 2;
        this.tH_ = this.texture_.height / 2;

    }

    public function draw(graphicsData:Vector.<IGraphicsData>, camera:Camera, time:int) : void
    {
        this.vS_.length = 0;
        this.vS_.push(
                this.posS_[3] - this.tW_,
                this. posS_[4] - this.tH_,
                this.posS_[3] + this.tW_,
                this.posS_[4] - this.tH_,
                this.posS_[3] + this.tW_,
                this.posS_[4] + this.tH_,
                this.posS_[3] - this.tW_,
                this.posS_[4] + this.tH_);
        this.path_.data = this.vS_;
        this.bitmapFill_.bitmapData = this.texture_;
        this.fillMatrix_.identity();
        this.fillMatrix_.translate(this.vS_[0],this.vS_[1]);
        this.bitmapFill_.matrix = this.fillMatrix_;
        graphicsData.push(this.bitmapFill_);
        graphicsData.push(this.path_);
        graphicsData.push(GraphicsUtil.END_FILL);
    }
}
}
