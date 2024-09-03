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

        this.credits = new Credits();
        this.credits.alpha = 0.5;
        addChild(this.credits);

        this.editorPanel = new EditorPanel(this);
        addChild(this.editorPanel);

        onResize();
    }

    public function onResize():void {
        if (!this.editorPanel.hasBeenMoved)
            this.editorPanel.y = Main.windowHeight / 2 - this.editorPanel.height / 2;
        if (this.editorPanel.x > Main.windowWidth)
            this.editorPanel.x = Main.windowWidth - this.editorPanel.width - 5;
        if (this.editorPanel.y > Main.windowHeight)
            this.editorPanel.y = Main.windowHeight - this.editorPanel.height - 5;
        this.credits.x = Main.windowWidth - this.credits.width - 2;
        this.credits.y = Main.windowHeight - this.credits.height - 2;
    }
}
}
