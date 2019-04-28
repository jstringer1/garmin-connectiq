using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;

class Service {

	function updateModel(model, info) {
		if(info has :timerTime) {
			model.setTimer(info.timerTime == null ? 0 : info.timerTime);
		}
		if(info has :elapsedDistance) {
			model.setDistance(info.elapsedDistance == null ? 0 : (info.elapsedDistance * 0.000621371));
		}
		if(info has :currentHeartRate){
       		model.setHr(info.currentHeartRate == null ? 0 : info.currentHeartRate);
       	}
	}
	
	function updateModelOnLap(model) {
		model.incrementLap();
	}

}
