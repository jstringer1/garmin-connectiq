using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Math;
using Toybox.Attention;

class DataField extends WatchUi.DataField {

	var model = new Model();
    var error;

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
        model.gap.update( info );
       	calculateNavigation( info );
    	if(info has :timerTime) {
    		model.timer = info.timerTime == null ? 0 : info.timerTime;
    	}
    	if(info has :elapsedDistance) {
    		model.distance = info.elapsedDistance == null ? 0 : (info.elapsedDistance * 0.000621371);
    	}
       	if(info has : averageSpeed) {
       		var speed = (info.averageSpeed == null ? 0 : info.averageSpeed) * 2.2369356;
       		model.avgPace = speed > 0 ? (60/speed) : 0;
       	}
       	if(info has :currentHeartRate){
       		model.hr = info.currentHeartRate == null ? 0 : info.currentHeartRate;
       	}
    }
    
    function calculateNavigation(info) {
       	if(info has :distanceToNextPoint && info has :nameOfNextPoint) {
       		var name = info.nameOfNextPoint == null ? "" : info.nameOfNextPoint;
       		var dist = info.distanceToNextPoint == null ? 0 : info.distanceToNextPoint;
       		if(dist > 0 && dist < 25) {
       			Attention.vibrate([new Attention.VibeProfile(100, 2000)]);
       		}
       		if(dist > 0 && dist < 100 && name != null) {
       			model.next = name;
       		} else {
       			model.next = null;
       		}
       	} else {
       		model.next = null;
       	}
    }

    function onUpdate( dc ) {
    	if(error != null) {
    		View.findDrawableById( "error_value" ).setText( error );
    	} else {
        	View.findDrawableById("View").setModel( model );
		}
        View.onUpdate( dc );
    }
}