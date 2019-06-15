using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using Formatter;
using ColourPicker;

class Distance extends WatchUi.Drawable {

	hidden var value;
	hidden var text;

    function initialize() {
    	value = 0;
        var dictionary = {
            :identifier => "Distance"
        };
        Drawable.initialize(dictionary);
    }

	function setValues(t, v) {
		text = t;
		value = v;
	}

    function draw(dc) {
    	var colour = ColourPicker.calculateColoursForDistance(value);
    	dc.setColor(colour.getBackground(), Graphics.COLOR_TRANSPARENT);
    	dc.fillRectangle(0, 56, 240, 50);
    	dc.setColor(colour.getHighlight(), Graphics.COLOR_TRANSPARENT);
    	dc.fillRectangle(0, 56, calculateBackgroundWidth(), 50);
		dc.setColor(colour.getForeground(), Graphics.COLOR_TRANSPARENT);
    	if(text == null) {
			dc.drawText(120, 65, Graphics.FONT_MEDIUM, Formatter.formatDistance(value), Graphics.TEXT_JUSTIFY_CENTER);
		} else {
			dc.drawText(120, 65, Graphics.FONT_MEDIUM, text, Graphics.TEXT_JUSTIFY_CENTER);
		}
    }
	
	function calculateBackgroundWidth() {
		return 240 * (value - value.toLong());
	}
}
