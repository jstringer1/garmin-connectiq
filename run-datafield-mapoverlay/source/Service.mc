class Service {

	hidden var formatter = new Formatter();
	hidden var pace = new RollingAvg();
    hidden var counter = 0;

	function updateModel(model, info) {
		var timer = 0;
		var distance = 0;
		var hr = 0;
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
        	var hr = info.currentHeartRate == null ? 0 : info.currentHeartRate;
        }
        model.setPace(formatter.formatPace(pace.get()));
        model.setHr(hr.format("%d"));
    	if(counter < 3) {
    		model.setProgress(formatter.formatDistance(distance));
    	} else if (counter < 6) {
    		model.setProgress(formatter.formatDuration(timer));
    	} else if (counter < 9) {
    		model.setProgress(formatter.formatPace(pace.get()));
    	} else {
    		model.setProgress(hr.format("%d"));
    	}
        if(info has :currentHeartRate){
        	var hr = info.currentHeartRate == null ? 0 : info.currentHeartRate;
        	model.setHr(hr.format("%d"));
        }
		counter = (counter + 1) % (model.getMini() ? 12 : 6);
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