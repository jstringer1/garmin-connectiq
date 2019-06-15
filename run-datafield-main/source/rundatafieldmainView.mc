using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Math;
using Toybox.Attention;

class rundatafieldmainView extends WatchUi.DataField {

	hidden var timer = 0;
	hidden var distance = 0;
	hidden var pace = new RollingAvg();
	hidden var avgPace = 0;
    hidden var hr = 0;
    hidden var error;
	hidden var next;

    function initialize() {
        DataField.initialize();
    }

    function onLayout(dc) {
    	if(dc.getWidth() < 240 || dc.getHeight() < 240) {
    		error = "TOO SMALL";
    		View.setLayout(Rez.Layouts.ErrorLayout(dc));
    	} else {
    		error = null;
        	View.setLayout(Rez.Layouts.MainLayout(dc));
        }
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
       	if(info has : averageSpeed) {
       		var speed = (info.averageSpeed == null ? 0 : info.averageSpeed) * 2.2369356;
       		avgPace = speed > 0 ? (60/speed) : 0;
       	}
       	if(info has :currentHeartRate){
       		hr = info.currentHeartRate == null ? 0 : info.currentHeartRate;
       	}
       	calculateNavigation(info);
    }
    
    function calculateNavigation(info) {
       	if(info has :distanceToNextPoint && info has :nameOfNextPoint) {
       		var name = info.nameOfNextPoint == null ? "" : info.nameOfNextPoint;
       		var dist = info.distanceToNextPoint == null ? 0 : info.distanceToNextPoint;
       		if(dist > 0 && dist < 25) {
       			Attention.vibrate([new Attention.VibeProfile(100, 2000)]);
       		}
       		if(dist > 0 && dist < 100 && name != null) {
       			next = name;
       		} else {
       			next = null;
       		}
       	} else {
       		next = null;
       	}
    }

    function onUpdate(dc) {
    	if(error != null) {
    		View.findDrawableById("error_value").setText(error);
    	} else {
        	View.findDrawableById("Timer").setValue(timer);
        	View.findDrawableById("Distance").setValues(next, distance);
        	View.findDrawableById("Pace").setValues(pace.get(), avgPace);
			View.findDrawableById("HR").setValue(hr);
		}
        View.onUpdate(dc);
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