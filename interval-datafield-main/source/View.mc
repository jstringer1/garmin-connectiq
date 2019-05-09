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
    	if(model.getView() == :activeLap) {
    		drawActiveLap(dc);
    	} else if(model.getView() == :inactiveLap) {
    		drawRecoveryLap(dc);
    	} else if(model.getView() == :laps) {
    		drawLaps(dc);
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
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.drawText(120, 10, Graphics.FONT_LARGE, formatDuration(model.getLapTimer()), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 40, Graphics.FONT_LARGE, formatDistance(model.getLapDistance(), true), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(20, 80, Graphics.FONT_NUMBER_HOT, model.getLapNumber().format("%d"), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(90, 75, Graphics.FONT_MEDIUM, formatDuration(model.getTimer()), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(90, 100, Graphics.FONT_MEDIUM, formatDistance(model.getDistance(), true), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(120, 140, Graphics.FONT_NUMBER_HOT, formatPace(model.getLapPace()), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 210, Graphics.FONT_MEDIUM, model.getHr().format("%d"), Graphics.TEXT_JUSTIFY_CENTER);
		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 75, 240, 5);
		dc.fillRectangle(0, 135, 240, 5);
		dc.fillRectangle(0, 195, 240, 5);
	}
	
	function drawLaps(dc) {
	    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
	    dc.drawText(120, 190, Graphics.FONT_NUMBER_MEDIUM, formatPace(model.getAvgLapPace()), Graphics.TEXT_JUSTIFY_CENTER);
		var y = 0;
		for(var i = model.getLapNumber(); i > 0; i--) {
			y = y + 25;
			if(y <= 150) {
				var pace = model.getLap(i-1).getPace();
				if(pace == model.getBestLapPace()) {
					dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
				} else if(pace < model.getAvgLapPace()) {
					dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
				} else {
					dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
				}
				dc.fillRectangle(0, y+5, 240, 25);
				dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
				dc.drawText(80, y, Graphics.FONT_LARGE, i.format("%d"), Graphics.TEXT_JUSTIFY_CENTER);
				dc.drawText(140, y, Graphics.FONT_LARGE, formatPace(model.getLap(i-1).getPace()), Graphics.TEXT_JUSTIFY_CENTER);
			}
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
    	if(model.getAvgLapPace() == 0) {
    		return Graphics.COLOR_WHITE;
    	}
    	if(model.getLapPace() < (model.getAvgLapPace() + 0.1) && model.getLapPace() > (model.getAvgLapPace() - 0.1)) {
    		return Graphics.COLOR_WHITE;
    	}
    	if(model.getLapPace() < model.getAvgLapPace()) {
    		return Graphics.COLOR_GREEN;
    	}
    	return Graphics.COLOR_RED;
    }
    
}
