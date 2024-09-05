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
        this.editorPanel.resize();
        this.credits.x = Main.windowWidth - this.credits.width - 2;
        this.credits.y = Main.windowHeight - this.credits.height - 2;
    }
}
}
