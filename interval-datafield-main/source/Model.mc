using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.Lang;

class Model {

	hidden var error;
	hidden var activeLap = false;
	hidden var timer = 0;
	hidden var distance = 0;
	hidden var distanceOffset = 0;
	hidden var timerOffset = 0;
	hidden var hr = 0;
	hidden var laps = new [0];
	
    function initialize() {
    }
    
    function incrementLap() {
    	if(activeLap) {
    		laps.add(new LapSummary(getLapPace(), getLapDistance(), getLapTimer()));
    	}
    	activeLap = !activeLap;
    	distanceOffset = distance;
    	timerOffset = timer;
    }
    
    function setTimer(t) {
    	timer = t;
    }
    
    function setDistance(d) {
    	distance = d;
    }
    
    function setHr(h) {
    	hr = h;
    }
    
    function setError(e) {
    	error = e;
    }
    
    function getError() {
    	return error;
    }
    
    function isActiveLap() {
    	return activeLap;
    }
    
    function getLapNumber() {
    	return laps.size();
    }
    
    function getTimer() {
    	return timer;
    }
    
    function getLapTimer() {
    	return timer - timerOffset;
    }
    
    function getDistance() {
    	return distance;
    }
    
    function getLapDistance() {
    	return distance - distanceOffset;
    }
    
    function getHr() {
    	return hr;
    }
    
    function getLapPace() {
    	return getLapDistance() == 0 ? 0 : (getLapTimer() / getLapDistance() / 60000);
    }
    
    function getLap(index) {
    	return laps[index];
    }
    
    function getBestLap() {
    	if(getLapNumber() == 0) {
    		return new LapSummary(0, 0, 0);
    	}
    	var best = getLap(0);
    	for(var i = 1; i<getLapNumber(); i++) {
    		if(getLap(i).getPace() < best.getPace()) {
    			best = getLap(i);
    		}
    	}
    	return best;
    }
    
    function getAvgLap() {
    	if(getLapNumber() == 0) {
    		return new LapSummary(0, 0, 0);
    	}
    	var pace = 0;
    	var distance = 0;
    	var duration = 0;
    	for(var i = 0; i<getLapNumber(); i++) {
    		pace = pace + getLap(i).getPace();
    		distance = distance + getLap(i).getDistance();
    		duration = duration + getLap(i).getDuration();
    	}
    	pace = pace / getLapNumber();
    	distance = distance / getLapNumber();
    	duration = duration / getLapNumber();
    	return new LapSummary(pace, distance, duration);
    }
    
    class LapSummary {
    	hidden var pace;
    	hidden var distance;
    	hidden var duration;
    	
    	function initialize(p, di, du) {
    		pace = p;
    		distance = di;
    		duration = du;
    	}
    	
    	function getPace() {
    		return pace;
    	}
    	
    	function getDistance() {
    		return distance;
    	}
    	
    	function getDuration() {
    		return duration;
    	}
    }
}