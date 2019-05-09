using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;

class Service {

	hidden var counter = 0;

	function updateModel(model, info) {
		incrementCounter(model);
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
		if(model.getView() == :activeLap) {
			var lapPace = model.getLapPace();
			model.addLap(lapPace, model.getLapDistance(), model.getLapTimer());
			if(model.getBestLapPace() == 0 || model.getBestLapPace() > lapPace) {
				model.setBestLapPace(lapPace);
			}
			calculateAndSetAvgLapPace(model);
			model.setView(:inactiveLap);
		} else {
			model.setView(:activeLap);
		}
    	model.setDistanceOffset(model.getDistance());
    	model.setTimerOffset(model.getTimer());
	}

	function incrementCounter(model) {
		if(model.getView() == :activeLap) {
			return;
		}
		counter = counter + 1;
		if(counter >= 4 && model.getLapNumber() >= 2) {
			if(model.getView() == :inactiveLap) {
				model.setView(:laps);
			} else {
				model.setView(:inactiveLap);
			}
			counter = 0;
		}
	}
	
	function calculateAndSetAvgLapPace(model) {
		var pace = 0;
    	for(var i = 0; i<model.getLapNumber(); i++) {
    		pace = pace + model.getLap(i).getPace();
    	}
    	pace = pace / model.getLapNumber();
    	model.setAvgLapPace(pace);
	}
}
