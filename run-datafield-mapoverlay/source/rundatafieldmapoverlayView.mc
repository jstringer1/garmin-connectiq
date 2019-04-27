using Toybox.WatchUi;
using Toybox.Graphics;

class rundatafieldmapoverlayView extends WatchUi.DataField {

	hidden var timer = 0;
	hidden var distance = 0;
	hidden var pace = new RollingAvg();
    hidden var hr = 0;
    
    hidden var counter = 0;
    hidden var showDistance = false;

    function initialize() {
        DataField.initialize();
    }

    function onLayout(dc) {
        return true;
    }

    function compute(info) {
    	if(info has :timerTime) {
    		timer = info.timerTime == null ? 0 : info.timerTime;
    	}
    	if(info has :elapsedDistance) {
    		distance = info.elapsedDistance == null ? 0 : (info.elapsedDistance * 0.000621371);
    	}
        if(info has :currentSpeed) {
        	var speed = (info.currentSpeed == null ? 0 : info.currentSpeed) * 2.2369356;
        	var paceData = speed > 0 ? (60/speed) : 0;
        	pace.add(paceData);
        }
        if(info has :currentHeartRate){
        	hr = info.currentHeartRate == null ? 0 : info.currentHeartRate;
        }
        counter = counter + 1;
        if(counter >= 4) {
			counter = 0;
			showDistance = !showDistance;
		}
    }

    function onUpdate(dc) {
        var progress = "";
        if(showDistance) {
        	progress = formatDistance(distance);
        } else {
        	progress = formatDuration(timer);
        }
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(0, 30, 240, 240);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(50, 28, Graphics.FONT_SMALL, formatPace(pace.get()), Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(120, 48, Graphics.FONT_XTINY, progress, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(181, 28, Graphics.FONT_SMALL, hr.format("%d"), Graphics.TEXT_JUSTIFY_RIGHT);
    }

    function formatDuration(duration) {
    	var hours = duration / 3600000;
    	var minutes = (duration / 60000) - (hours*60);
    	var seconds = (duration / 1000) - (hours*3600) - (minutes*60);
    	return hours.format("%02d")+":"+minutes.format("%02d")+":"+seconds.format("%02d");
    }
    
    function formatDistance(distance) {
    	return distance.format("%.2f") + " Miles";
    }
    
    function formatPace(pace) {
    	return pace <= 0 ? "--:--" : pace.format("%02d") + ":" +((pace-Toybox.Math.floor(pace)) * 60).format("%02d");
    }
    
    class RollingAvg {
    	hidden var data = new[10];
    	hidden var pointer = 0;
    	
		function add(pace) {
    		data[pointer] = pace;
    		pointer = (pointer + 1) % 10;
    	}
    	
    	function get() {
    		var sum = 0;
    		for(var i = 0; i < 10; i++) {
    			if(data[i] == null) {
    				return 0;
    			}
    			sum = sum + data[i];
    		}
    		return (sum / 10);
    	}
    }
}
