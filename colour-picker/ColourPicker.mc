using Toybox.Graphics;

module ColourPicker {

	const MAX_HR = 195;

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
	
	function calculateColoursForHr(hr) {
		if(hr > (MAX_HR*0.97)) {
    		return new ColourPair(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
    	} else if(hr > (MAX_HR*0.87)) {
    		return new ColourPair(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
    	} else if(hr > (MAX_HR*0.77)) {
    		return new ColourPair(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
    	} else if(hr > (MAX_HR*0.66)) {
    		return new ColourPair(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
    	}
    	return new ColourPair(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
	}
	
	function calculateHighlightColourForTargetPace(targetPace, pace) {
		if(targetPace == null || targetPace == 0) {
			return Graphics.COLOR_WHITE;
		}
		if(pace < (targetPace + 0.1) && pace > (targetPace - 0.1)) {
    		return Graphics.COLOR_GREEN;
    	}
    	if(pace < targetPace) {
    		return Graphics.COLOR_BLUE;
    	}
    	return Graphics.COLOR_RED;
	}
	
	function calculateHighlightColourForRelativePace(avgPace, maxPace, pace) {
		if(pace == maxPace) {
			return Graphics.COLOR_YELLOW;
		} else if(pace < avgPace) {
			return Graphics.COLOR_GREEN;
		} else {
			return Graphics.COLOR_RED;
		}
	}
}
