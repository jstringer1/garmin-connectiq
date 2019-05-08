using Toybox.Graphics;

module ColourPicker {

	function calculateColorsForPace(pace) {
		if(pace == 0) {
			return new ColourPair(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
		} else if(pace > 9) {
    		return new ColourPair(Graphics.COLOR_DK_RED, Graphics.COLOR_WHITE);
	  		} else if(pace > 8) {
    		return new ColourPair(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
    	} else if(pace > 7.5) {
    		return new ColourPair(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
    	} else if(pace > 7) {
    		return new ColourPair(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
    	} else if(pace > 6.5) {
    		return new ColourPair(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
    	} else if(pace > 6) {
    		return new ColourPair(Graphics.COLOR_PURPLE, Graphics.COLOR_WHITE);
    	}
    	return new ColourPair(Graphics.COLOR_PINK, Graphics.COLOR_BLACK);
	}

	function calculateColoursForDistance(distance) {
		if(distance == 0) {
			return new ColourTriplet(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
		} else if(distance < 3.1) {
			return new ColourTriplet(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE, Graphics.COLOR_RED);
		} else if(distance < 5) {
			return new ColourTriplet(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK, Graphics.COLOR_ORANGE);
		} else if(distance < 6.2) {
			return new ColourTriplet(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK, Graphics.COLOR_YELLOW);
		} else if(distance < 10) {
			return new ColourTriplet(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK, Graphics.COLOR_GREEN);
		} else if(distance < 13.1) {
			return new ColourTriplet(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK, Graphics.COLOR_BLUE);
		} else if(distance < 26.2) {
			return new ColourTriplet(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE, Graphics.COLOR_PURPLE);
		}
    	return new ColourTriplet(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK, Graphics.COLOR_PINK);
	}
}
