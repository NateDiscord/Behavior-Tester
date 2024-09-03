package Engine.File {
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class FileReader {
    private var onCompleteCallback:Function;

    public function FileReader(callback:Function, dir:String) {
        this.onCompleteCallback = callback;
        var request:URLRequest = new URLRequest(dir);
        var urlLoader:URLLoader = new URLLoader();
        urlLoader.addEventListener(Event.COMPLETE, onFileLoadComplete);
        urlLoader.load(request);
    }

    private function onFileLoadComplete(event:Event):void {
        var content:String = URLLoader(event.target).data as String;
        if (this.onCompleteCallback != null) {
            this.onCompleteCallback(content);
        }
    }
}
}
