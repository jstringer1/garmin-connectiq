using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;

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
    	var colors = getColorsForPace(value);
    	var avgColors = getColorsForPace(avgValue);
    	dc.setColor(colors.getBackground(), Graphics.COLOR_TRANSPARENT);
    	dc.fillRectangle(122, 111, 118, 74);
    	dc.setColor(avgColors.getBackground(), Graphics.COLOR_TRANSPARENT);
    	dc.fillRectangle(0, 111, 118, 74);
		dc.setColor(colors.getForeground(), Graphics.COLOR_TRANSPARENT);
		dc.drawText(180, 130, Graphics.FONT_LARGE, formatPace(value), Graphics.TEXT_JUSTIFY_CENTER);
		dc.setColor(avgColors.getForeground(), Graphics.COLOR_TRANSPARENT);
		dc.drawText(60, 130, Graphics.FONT_LARGE, formatPace(avgValue), Graphics.TEXT_JUSTIFY_CENTER);
    }

	function getColorsForPace(pace) {
		if(pace == 0) {
			return new PaceColorPallete(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
		} else if(pace > 9) {
    		return new PaceColorPallete(Graphics.COLOR_DK_RED, Graphics.COLOR_WHITE);
	   	} else if(pace > 8) {
    		return new PaceColorPallete(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
    	} else if(pace > 7.5) {
    		return new PaceColorPallete(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
    	} else if(pace > 7) {
    		return new PaceColorPallete(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
    	} else if(pace > 6.5) {
    		return new PaceColorPallete(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
    	} else if(pace > 6) {
    		return new PaceColorPallete(Graphics.COLOR_PURPLE, Graphics.COLOR_WHITE);
    	}
    	return new PaceColorPallete(Graphics.COLOR_PINK, Graphics.COLOR_BLACK);
	}
	
	function formatPace(pace) {
    	return pace <= 0 ? "--:--" : pace.format("%02d") + ":" +((pace-Toybox.Math.floor(pace)) * 60).format("%02d");
    }
    
    class PaceColorPallete {
    	hidden var background;
    	hidden var foreground;
    	
    	function initialize(b, f) {
    		background = b;
    		foreground = f;
    	}
    	
    	function getBackground() {
    		return background;
    	}
    	
    	function getForeground() {
    		return foreground;
    	}
    }
}
