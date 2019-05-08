using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using Formatter;

class Timer extends WatchUi.Drawable {

	hidden var value;

    function initialize() {
    	value = 0;
        var dictionary = {
            :identifier => "Timer"
        };
        Drawable.initialize(dictionary);
    }

	function setValue(v) {
		value = v;
	}

    function draw(dc) {
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.drawText(120, 8, Graphics.FONT_MEDIUM, Formatter.formatDuration(value), Graphics.TEXT_JUSTIFY_CENTER);
    }
}
