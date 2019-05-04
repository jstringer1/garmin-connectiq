class Service {

	hidden var formatter = new Formatter();
	hidden var state = new RollingState();
	hidden var showDistance = false;
	hidden var count = 0;
	
	function updateModel(model, info) {
		incrementCount();
		var pace = 0;
		var elapsedDistance = 0;
		var altitude = 0;
		if(info has :currentSpeed) {
       		var speed = (info.currentSpeed == null ? 0 : info.currentSpeed) * 2.2369356;
       		pace = speed > 0 ? (60/speed) : 0;
       	}
		if(info has :elapsedDistance) {
			elapsedDistance = info.elapsedDistance == null ? 0 : info.elapsedDistance * 0.000621371;
		}
    	if(info has :altitude) {
    		altitude = (info.altitude == null ? 0 : (info.altitude * 3.28084));
    	}
    	state.add(pace, (elapsedDistance * 5280), altitude);		
    	if(!showDistance && info has :timerTime) {
    		model.setProgress(formatter.formatDuration(info.timerTime == null ? 0 : info.timerTime));
    	} else {
    		model.setProgress(formatter.formatDistance(elapsedDistance));
    	}
       	if(info has : averageSpeed) {
       		var speed = (info.averageSpeed == null ? 0 : info.averageSpeed) * 2.2369356;
       		model.setAvgPace(formatter.formatPace(speed > 0 ? (60/speed) : 0));
       	}
       	if(info has :currentHeartRate){
       		model.setHr(info.currentHeartRate == null ? "0" : info.currentHeartRate.format("%d"));
       	}
    	model.setPace(formatter.formatPace(state.getCurrentPace()));
    	model.setGrade(state.getCurrentGrade().format("%.1f")+"%");
    	model.setAscent(state.getTotalAscent().format("%.1f"));
	}

    function incrementCount() {
    	count = count + 1;
    	if(count >= 4) {
    		count = 0;
    		showDistance = !showDistance;
    	}
    }
    
    class RollingState {
        hidden var data = new[10];
    	hidden var pointer = 0;
    	hidden var totalAscent = 0;
    	
    	function add(pace, distance, altitude) {
    		var currentSample = new Sample();
    		currentSample.pace = pace;
    		currentSample.distance = distance;
    		currentSample.altitude = altitude;
    		data[pointer] = currentSample;
    		pointer = (pointer + 1) % 10;
    		if(distance <= 0) {
    			return;
    		}
    		var previousSample = data[(pointer+8)%10];
    		if(previousSample != null && previousSample.altitude < altitude) {
    			totalAscent = totalAscent + (altitude - previousSample.altitude);
    		}
    	}
    	
    	function getCurrentGrade() {
    		var oldestSample = data[pointer];
    		var currentSample = data[(pointer+9)%10];
    		if(oldestSample == null || currentSample == null || currentSample.distance == 0) {
    			return 0;
    		}
    		return (currentSample.altitude - oldestSample.altitude) / (currentSample.distance - oldestSample.distance) * 100;
    	}
    	
    	function getCurrentPace() {
    		var sum = 0;
    		for(var i = 0; i < 10; i++) {
    			if(data[i] == null) {
    				return 0;
    			}
    			sum = sum + data[i].pace;
    		}
    		return (sum / 10);
    	}
    	
    	function getTotalAscent() {
    		return totalAscent;
    	}
    
    	class Sample {
    		var pace = 0;
    		var distance = 0;
    		var altitude = 0;
    	}
    }
}