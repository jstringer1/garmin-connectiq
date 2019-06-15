using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using Formatter;
using ColourPicker;

class View extends WatchUi.Drawable {

	hidden var model;

    function initialize() {
        Drawable.initialize({:identifier => "view"});
    }

	function setModel(m) {
		model = m;
	}

    function draw(dc) {
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    	dc.fillRectangle(0,0,240,240);
    	if(model.getView() == :activeLap) {
    		drawActiveLap(dc);
    	} else if(model.getView() == :inactiveLap) {
    		drawRecoveryLap(dc);
    	} else if(model.getView() == :laps) {
    		drawLaps(dc);
    	}
    }
	
	function drawActiveLap(dc) {
		drawHr(dc);
		dc.setColor(ColourPicker.calculateHighlightColourForTargetPace(model.getAvgLapPace(), model.getLapPace()), Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 80, 240, 55);
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.drawText(120, 20, Graphics.FONT_NUMBER_MEDIUM, Formatter.formatDurationShort(model.getLapTimer()), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 80, Graphics.FONT_NUMBER_HOT, Formatter.formatPace(model.getLapPace()), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 150, Graphics.FONT_NUMBER_MEDIUM, Formatter.formatDistanceWithoutLabel(model.getLapDistance()), Graphics.TEXT_JUSTIFY_CENTER);
		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 75, 240, 5);
		dc.fillRectangle(0, 135, 240, 5);
		dc.fillRectangle(0, 195, 240, 5);
	}
	
	function drawRecoveryLap(dc) {
		drawHr(dc);
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.drawText(120, 10, Graphics.FONT_LARGE, Formatter.formatDurationShort(model.getLapTimer()), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 40, Graphics.FONT_LARGE, Formatter.formatDistance(model.getLapDistance()), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 80, Graphics.FONT_NUMBER_HOT, Formatter.formatPace(model.getLapPace()), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(80, 140, Graphics.FONT_NUMBER_HOT, model.getLapNumber().format("%d"), Graphics.TEXT_JUSTIFY_RIGHT);
		dc.drawText(100, 135, Graphics.FONT_MEDIUM, Formatter.formatDistance(model.getDistance()), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(100, 160, Graphics.FONT_MEDIUM, Formatter.formatDurationShort(model.getTimer()), Graphics.TEXT_JUSTIFY_LEFT);
		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 75, 240, 5);
		dc.fillRectangle(0, 135, 240, 5);
		dc.fillRectangle(0, 195, 240, 5);
	}
	
	function drawLaps(dc) {
	    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
	    dc.drawText(120, 190, Graphics.FONT_NUMBER_MEDIUM, Formatter.formatPace(model.getAvgLapPace()), Graphics.TEXT_JUSTIFY_CENTER);
		var y = 0;
		for(var i = model.getLapNumber(); i > 0; i--) {
			y = y + 25;
			if(y <= 150) {
				var pace = model.getLap(i-1).getPace();
				dc.setColor(ColourPicker.calculateHighlightColourForRelativePace(model.getAvgLapPace(), model.getBestLapPace(), pace), Graphics.COLOR_TRANSPARENT);
				dc.fillRectangle(0, y+5, 240, 25);
				dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
				dc.drawText(80, y, Graphics.FONT_LARGE, i.format("%d"), Graphics.TEXT_JUSTIFY_CENTER);
				dc.drawText(140, y, Graphics.FONT_LARGE, Formatter.formatPace(model.getLap(i-1).getPace()), Graphics.TEXT_JUSTIFY_CENTER);
			}
		}
	}
	
	function drawHr(dc) {
		var colours = ColourPicker.calculateColoursForHr(model.getHr());
		dc.setColor(colours.getBackground(), Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 200, 240, 40);
		dc.setColor(colours.getForeground(), Graphics.COLOR_TRANSPARENT);
		dc.drawText(120, 200, Graphics.FONT_MEDIUM, model.getHr().format("%d"), Graphics.TEXT_JUSTIFY_CENTER);
	}  
}
