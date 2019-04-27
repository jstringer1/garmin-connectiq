using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;

class HR extends WatchUi.Drawable {

	hidden var maxValue = 195;
	hidden var value;

    function initialize() {
    	value = 0;
        var dictionary = {
            :identifier => "HR"
        };
        Drawable.initialize(dictionary);
    }

	function setValue(v) {
		value = v;
	}

    function draw(dc) {
    	var bgColor = calculateBackgroundColor();
    	var fgColor = bgColor == Graphics.COLOR_RED ? Graphics.COLOR_WHITE : Graphics.COLOR_BLACK;
    	dc.setColor(bgColor, Graphics.COLOR_TRANSPARENT);
    	dc.fillRectangle(0, 190, 240, 50);
		dc.setColor(fgColor, Graphics.COLOR_TRANSPARENT);
		dc.drawText(120, 195, Graphics.FONT_LARGE, value.format("%d"), Graphics.TEXT_JUSTIFY_CENTER);
    }

	function calculateBackgroundColor() {
		if(value > (maxValue*0.97)) {
    		return Graphics.COLOR_RED;
    	} else if(value > (maxValue*0.87)) {
    		return Graphics.COLOR_YELLOW;
    	} else if(value > (maxValue*0.77)) {
    		return Graphics.COLOR_GREEN;
    	} else if(value > (maxValue*0.66)) {
    		return Graphics.COLOR_BLUE;
    	}
    	return Graphics.COLOR_WHITE;
	}
}
