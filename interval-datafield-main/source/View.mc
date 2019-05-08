using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;

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
    	if(model.isActiveLap()) {
    		drawActiveLap(dc);
    	} else {
    		drawRecoveryLap(dc);
    	}
    }
	
	function drawActiveLap(dc) {
		dc.setColor(getPaceColor(), Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 80, 240, 55);
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.drawText(120, 20, Graphics.FONT_NUMBER_MEDIUM, formatDuration(model.getLapTimer()), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 80, Graphics.FONT_NUMBER_HOT, formatPace(model.getLapPace()), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 150, Graphics.FONT_NUMBER_MEDIUM, formatDistance(model.getLapDistance(), false), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 200, Graphics.FONT_LARGE, model.getHr().format("%d"), Graphics.TEXT_JUSTIFY_CENTER);
		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 75, 240, 5);
		dc.fillRectangle(0, 135, 240, 5);
		dc.fillRectangle(0, 195, 240, 5);
	}
	
	function drawRecoveryLap(dc) {
		drawLaps(dc);
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.drawText(20, 95, Graphics.FONT_NUMBER_HOT, model.getLapNumber().format("%d"), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(90, 90, Graphics.FONT_MEDIUM, formatDuration(model.getTimer()), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(90, 115, Graphics.FONT_MEDIUM, formatDistance(model.getDistance(), true), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(120, 155, Graphics.FONT_NUMBER_HOT, formatPace(model.getLapPace()), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 210, Graphics.FONT_MEDIUM, model.getHr().format("%d"), Graphics.TEXT_JUSTIFY_CENTER);
		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 90, 240, 5);
		dc.fillRectangle(0, 150, 240, 5);
		dc.fillRectangle(0, 210, 240, 5);
	}
	
	function drawLaps(dc) {
	    if(model.getLapNumber() > 1) {
	    	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
	    	dc.drawText(120, 2, Graphics.FONT_SMALL, formatPace(model.getAvgLap().getPace()), Graphics.TEXT_JUSTIFY_CENTER);
	    	dc.drawText(120, 60, Graphics.FONT_SMALL, formatPace(model.getBestLap().getPace()), Graphics.TEXT_JUSTIFY_CENTER);
	    	dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
	    	dc.drawText(120, 20, Graphics.FONT_SMALL, formatPace(model.getLap(model.getLapNumber()-1).getPace()), Graphics.TEXT_JUSTIFY_CENTER);
	    	dc.drawText(120, 40, Graphics.FONT_SMALL, formatPace(model.getLap(model.getLapNumber()-2).getPace()), Graphics.TEXT_JUSTIFY_CENTER);
	    	dc.drawText(60, 20, Graphics.FONT_SMALL, model.getLapNumber(), Graphics.TEXT_JUSTIFY_CENTER);
	    	dc.drawText(60, 40, Graphics.FONT_SMALL, (model.getLapNumber() - 1), Graphics.TEXT_JUSTIFY_CENTER);
	    } else {
	    	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
	    	dc.drawText(120, 30, Graphics.FONT_LARGE, formatPace(model.getAvgLap().getPace()), Graphics.TEXT_JUSTIFY_CENTER);
	    }
	}
	
    function formatDuration(duration) {
    	var hours = duration / 3600000;
    	var minutes = (duration / 60000) - (hours*60);
    	var seconds = (duration / 1000) - (hours*3600) - (minutes*60);
    	if(hours > 0) {
    		return hours.format("%02d")+":"+minutes.format("%02d")+":"+seconds.format("%02d");
    	}
    	return minutes.format("%02d")+":"+seconds.format("%02d");
    }
    
    function formatDistance(distance, label) {
    	if(label) {
    		return distance.format("%.2f")+" Miles";
    	} else {
    		return distance.format("%.2f");
    	}
    }
    
	function formatPace(pace) {
    	return pace <= 0 ? "--:--" : pace.format("%02d") + ":" +((pace-Toybox.Math.floor(pace)) * 60).format("%02d");
    }
    
    function getPaceColor() {
    	var avg = model.getAvgLap();
    	if(avg.getPace() == 0) {
    		return Graphics.COLOR_WHITE;
    	}
    	if(model.getLapPace() < (avg.getPace() + 0.1) && model.getLapPace() > (avg.getPace() - 0.1)) {
    		return Graphics.COLOR_WHITE;
    	}
    	if(model.getLapPace() < avg.getPace()) {
    		return Graphics.COLOR_GREEN;
    	}
    	return Graphics.COLOR_RED;
    }
    
}
