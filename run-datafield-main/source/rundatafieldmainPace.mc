using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using ColourPicker;
using Formatter;

class Pace extends WatchUi.Drawable {

	hidden var value;
	hidden var avgValue;

    function initialize() {
    	value = 0;
    	avgValue = 0;
        var dictionary = {
            :identifier => "Pace"
        };
        Drawable.initialize(dictionary);
    }

	function setValues(v, a) {
		value = v;
		avgValue = a;
	}

    function draw(dc) {
    	var colors = ColourPicker.calculateColorsForPace(value);
    	var avgColors = ColourPicker.calculateColorsForPace(avgValue);
    	dc.setColor(colors.getBackground(), Graphics.COLOR_TRANSPARENT);
    	dc.fillRectangle(122, 111, 118, 74);
    	dc.setColor(avgColors.getBackground(), Graphics.COLOR_TRANSPARENT);
    	dc.fillRectangle(0, 111, 118, 74);
		dc.setColor(colors.getForeground(), Graphics.COLOR_TRANSPARENT);
		dc.drawText(180, 130, Graphics.FONT_LARGE, Formatter.formatPace(value), Graphics.TEXT_JUSTIFY_CENTER);
		dc.setColor(avgColors.getForeground(), Graphics.COLOR_TRANSPARENT);
		dc.drawText(60, 130, Graphics.FONT_LARGE, Formatter.formatPace(avgValue), Graphics.TEXT_JUSTIFY_CENTER);
    }
}
