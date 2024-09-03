package Display.Assets.Elements
{
import Display.Text.SimpleText;

import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;

public class TextInputField extends Sprite
{

    public static const HEIGHT:int = 88;


    public var nameText_:SimpleText;

    public var inputText_:SimpleText;

    public function TextInputField(name:String, isPassword:Boolean, error:String, width:int = 238, height:int = 30, inputWidth:int = 20)
    {
        super();
        this.nameText_ = new SimpleText(18,11776947,false,0,0);
        this.nameText_.setBold(true);
        this.nameText_.text = name;
        this.nameText_.updateMetrics();
        this.nameText_.filters = [new DropShadowFilter(0,0,0)];
        addChild(this.nameText_);
        this.inputText_ = new SimpleText(inputWidth,0xcccccc,true,width,height);
        this.inputText_.setBold(true);
        this.inputText_.y = 1;
        this.inputText_.x = 6;
        this.inputText_.border = false;
        this.inputText_.displayAsPassword = isPassword;
        this.inputText_.updateMetrics();
        addChild(this.inputText_);
        graphics.lineStyle(2,0x363636,1,false,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND);
        graphics.beginFill(0x181818,1);
        graphics.drawRect(0,0,width,height);
        graphics.endFill();
        graphics.lineStyle();
        this.inputText_.addEventListener(Event.CHANGE,this.onInputChange);
    }

    public function text() : String
    {
        return this.inputText_.text;
    }

    public function setText(text:String):void
    {
        this.inputText_.text = text;
        this.inputText_.updateMetrics();
    }

    public function setError(error:String) : void
    {
    }

    public function onInputChange(event:Event) : void
    {
        this.setError("");
    }
}
}
