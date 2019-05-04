using Toybox.WatchUi;

class FullView extends WatchUi.Drawable {
	hidden var model;
	
	function initialize(m) {
		model = m;
        Drawable.initialize({:identifier => "view"});
    }
	
	function draw(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(0, 30, 240, 240);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(50, 28, Graphics.FONT_SMALL, model.getPace(), Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(120, 48, Graphics.FONT_XTINY, model.getProgress(), Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(181, 28, Graphics.FONT_SMALL, model.getHr(), Graphics.TEXT_JUSTIFY_RIGHT);
    }
    
}