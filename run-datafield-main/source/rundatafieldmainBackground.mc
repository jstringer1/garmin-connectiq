using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;

class Background extends WatchUi.Drawable {

    function initialize() {
        var dictionary = {
            :identifier => "Background"
        };
        Drawable.initialize(dictionary);
    }

    function draw(dc) {
    	dc.clear();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Toybox.Graphics.COLOR_WHITE);
        var backgroundImg = Toybox.WatchUi.loadResource(Rez.Drawables.BackgroundImage);
        dc.drawBitmap(0, 0, backgroundImg);
    }

}
