using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;

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
		dc.drawText(120, 8, Graphics.FONT_MEDIUM, formatDuration(value), Graphics.TEXT_JUSTIFY_CENTER);
    }
	
    function formatDuration(duration) {
    	var hours = duration / 3600000;
    	var minutes = (duration / 60000) - (hours*60);
    	var seconds = (duration / 1000) - (hours*3600) - (minutes*60);
    	return hours.format("%02d")+":"+minutes.format("%02d")+":"+seconds.format("%02d");
    }
}
