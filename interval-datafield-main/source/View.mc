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
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.drawText(120, 20, Graphics.FONT_NUMBER_HOT, formatDuration(model.getLapTimer()), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 80, Graphics.FONT_NUMBER_HOT, formatPace(model.getLapPace()), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 140, Graphics.FONT_NUMBER_HOT, formatDistance(model.getLapDistance(), false), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 200, Graphics.FONT_LARGE, model.getHr().format("%d"), Graphics.TEXT_JUSTIFY_CENTER);
		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 75, 240, 5);
		dc.fillRectangle(0, 135, 240, 5);
		dc.fillRectangle(0, 195, 240, 5);
	}
	
	function drawRecoveryLap(dc) {
	    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
	    dc.drawText(120, 8, Graphics.FONT_MEDIUM, formatPace(model.getBestLap().getPace()), Graphics.TEXT_JUSTIFY_CENTER);
	    dc.drawText(25, 40, Graphics.FONT_MEDIUM, formatDuration(model.getBestLap().getDuration()), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(215, 42, Graphics.FONT_SMALL, formatDistance(model.getBestLap().getDistance(), true), Graphics.TEXT_JUSTIFY_RIGHT);
		dc.drawText(20, 90, Graphics.FONT_NUMBER_HOT, model.getLapNumber().format("%d"), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(90, 85, Graphics.FONT_MEDIUM, formatDuration(model.getTimer()), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(90, 110, Graphics.FONT_MEDIUM, formatDistance(model.getDistance(), true), Graphics.TEXT_JUSTIFY_LEFT);
		dc.drawText(120, 155, Graphics.FONT_NUMBER_HOT, formatPace(model.getLapPace()), Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(120, 210, Graphics.FONT_MEDIUM, model.getHr().format("%d"), Graphics.TEXT_JUSTIFY_CENTER);
		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0, 80, 240, 5);
		dc.fillRectangle(0, 145, 240, 5);
		dc.fillRectangle(0, 210, 240, 5);
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
}
