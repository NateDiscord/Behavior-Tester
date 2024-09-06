package Display.Assets.Elements
{
   import flash.display.CapsStyle;
   import flash.display.Graphics;
   import flash.display.JointStyle;
   import flash.display.LineScaleMode;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   
   public class CheckBoxField extends Sprite
   {
      
      private static const BOX_SIZE:int = 20;
       
      
      public var checkBox_:Sprite;
      
      private var checked_:Boolean;
      
      private var hasError:Boolean;
      
      public function CheckBoxField(checked:Boolean)
      {
         super();
         this.checked_ = checked;
         this.checkBox_ = new Sprite();
         this.checkBox_.x = 2;
         this.checkBox_.y = 2;
         this.redrawCheckBox();
         this.checkBox_.addEventListener("click",this.onClick);
         addChild(this.checkBox_);
      }
      
      public function isChecked() : Boolean
      {
         return this.checked_;
      }

      public function setChecked():void
      {
         this.checked_ = true;
         this.redrawCheckBox();
      }

      public function setUnchecked():void
      {
         this.checked_ = false;
         this.redrawCheckBox();
      }
      
      private function onClick(event:MouseEvent) : void
      {
         this.checked_ = !this.checked_;
         this.redrawCheckBox();
      }
      
      public function setErrorHighlight(value:Boolean) : void
      {
         this.hasError = value;
         this.redrawCheckBox();
      }
      
      private function redrawCheckBox() : void
      {
         var color:Number = NaN;
         var g:Graphics = this.checkBox_.graphics;
         g.clear();
         g.beginFill(3355443,1);
         g.drawRect(0,0,BOX_SIZE,BOX_SIZE);
         g.endFill();
         if(this.checked_)
         {
            g.lineStyle(4,11776947,1,false,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND);
            g.moveTo(2,2);
            g.lineTo(BOX_SIZE - 2,BOX_SIZE - 2);
            g.moveTo(2,BOX_SIZE - 2);
            g.lineTo(BOX_SIZE - 2,2);
            g.lineStyle();
            this.hasError = false;
         }
         if(this.hasError)
         {
            color = 16549442;
         }
         else
         {
            color = 4539717;
         }
         g.lineStyle(2,color,1,false,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND);
         g.drawRect(0,0,BOX_SIZE,BOX_SIZE);
         g.lineStyle();
      }
   }
}
