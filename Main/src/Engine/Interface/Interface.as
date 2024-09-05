package Engine.Interface {
import Engine.Interface.Editor.EditorPanel;
import Engine.Manager;

import flash.display.Sprite;

public class Interface extends Sprite {

    public var editorPanel:EditorPanel;
    public var credits:Credits;

    public var manager:Manager;

    public function Interface(manager:Manager) {
        this.manager = manager;

        this.editorPanel = new EditorPanel(this);
        addChild(this.editorPanel);

        this.credits = new Credits();
        this.credits.alpha = 0.5;
        addChild(this.credits);

        onResize();
    }

    public function onResize():void {
        var scale:Number = Main.STAGE.stageHeight / 720 > 1 ? 1 : Main.STAGE.stageHeight / 720;
        this.editorPanel.scaleX = this.editorPanel.scaleY = scale;
        if (!this.editorPanel.hasBeenMoved)
            this.editorPanel.y = (Main.windowHeight - this.editorPanel.height) / 2;
        this.editorPanel.x = Math.min(this.editorPanel.x, Main.windowWidth - this.editorPanel.width - 5);
        this.editorPanel.y = Math.min(this.editorPanel.y, Main.windowHeight - this.editorPanel.height - 5);

        this.credits.x = Main.windowWidth - this.credits.width - 2;
        this.credits.y = Main.windowHeight - this.credits.height - 2;
    }
}
}
