using Toybox.WatchUi;

class MiniView extends WatchUi.Drawable {
	hidden var model;
	
	function initialize(m) {
		model = m;
        Drawable.initialize({:identifier => "view"});
    }
	
	function draw(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawText(2, 2, Graphics.FONT_XTINY, model.getProgress(), Graphics.TEXT_JUSTIFY_LEFT);
    }
}