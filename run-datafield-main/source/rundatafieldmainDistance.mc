using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using Formatter;

class Distance extends WatchUi.Drawable {

	hidden var value;

    function initialize() {
    	value = 0;
        var dictionary = {
            :identifier => "Distance"
        };
        Drawable.initialize(dictionary);
    }

	function setValue(v) {
		value = v;
	}

    function draw(dc) {
    	
    	dc.setColor(calculateBackgroundColor(), Graphics.COLOR_TRANSPARENT);
    	dc.fillRectangle(0, 56, calculateBackgroundWidth(), 50);
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.drawText(120, 65, Graphics.FONT_MEDIUM, Formatter.formatDistance(value), Graphics.TEXT_JUSTIFY_CENTER);
    }

	function calculateBackgroundColor() {
		if(value == 0) {
			return Graphics.COLOR_WHITE;
		} else if(value < 3.1) {
			return Graphics.COLOR_RED;
		} else if(value < 5) {
			return Graphics.COLOR_ORANGE;
		} else if(value < 6.2) {
			return Graphics.COLOR_YELLOW;
		} else if(value < 10) {
			return Graphics.COLOR_GREEN;
		} else if(value < 13.1) {
			return Graphics.COLOR_BLUE;
		} else if(value < 26.2) {
			return Graphics.COLOR_PURPLE;
		}
    	return Graphics.COLOR_PINK;
	}
	
	function calculateBackgroundWidth() {
		return 240 * (value - value.toLong());
	}
}
