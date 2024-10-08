package Engine.Interface {
import Engine.Manager;

import flash.display.Sprite;

public class Interface extends Sprite {

    public var editorPanel:Editor;
    public var credits:Credits;

    public var manager:Manager;

    public function Interface(manager:Manager) {
        this.manager = manager;

        this.credits = new Credits();
        this.credits.alpha = 0.5;
        addChild(this.credits);

        this.editorPanel = new Editor(this);
        addChild(this.editorPanel);

        onResize();
    }

    public function onResize():void {
        this.editorPanel.resize();
        this.credits.x = Main.STAGE.stageWidth - this.credits.width - 2;
        this.credits.y = Main.STAGE.stageHeight - this.credits.height - 2;
    }
}
}
