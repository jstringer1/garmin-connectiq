using Toybox.WatchUi;

class View extends WatchUi.Drawable {
	hidden var model;
	
	function initialize() {
        Drawable.initialize({:identifier => "view"});
    }
	
	function setModel(m) {
		model = m;
	}
	
	function draw(dc) {
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0,0,240,240);
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.drawText(120, 10, Graphics.FONT_LARGE, model.getProgress(), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(60, 70, Graphics.FONT_NUMBER_MEDIUM, model.getPace(), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(180, 70, Graphics.FONT_NUMBER_MEDIUM, model.getAvgPace(), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(60, 140, Graphics.FONT_NUMBER_MEDIUM, model.getAscent(), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(180, 140, Graphics.FONT_NUMBER_MEDIUM, model.getGrade(), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 200, Graphics.FONT_LARGE, model.getHr(), Graphics.TEXT_JUSTIFY_CENTER);
		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 60, 240, 5);
		dc.fillRectangle(0, 125, 240, 5);
		dc.fillRectangle(0, 190, 240, 5);
		dc.fillRectangle(118, 60, 4, 135);
    }
    
}