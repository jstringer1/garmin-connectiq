using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using Formatter;
using ColourPicker;

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
    	var colours = ColourPicker.calculateColoursForHr(value);
    	dc.setColor(colours.getBackground(), Graphics.COLOR_TRANSPARENT);
    	dc.fillRectangle(0, 190, 240, 50);
		dc.setColor(colours.getForeground(), Graphics.COLOR_TRANSPARENT);
		dc.drawText(120, 195, Graphics.FONT_LARGE, Formatter.formatHr(value), Graphics.TEXT_JUSTIFY_CENTER);
    }
}
