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
	hidden var view = :inactiveLap;
	hidden var avgLapPace = 0;
	hidden var bestLapPace = 0;
    
    function setView(v) {
    	view = v;
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
    
    function setDistanceOffset(d) {
    	distanceOffset = d;
    }
    
    function setTimerOffset(t) {
    	timerOffset = t;
    }
    
    function setBestLapPace(p) {
    	bestLapPace = p;
    }
    
    function setAvgLapPace(p) {
    	avgLapPace = p;
    }
    
    function addLap(pace, distance, duration) {
    	laps.add(new LapSummary(pace, distance, duration));
    }
    
    function getView() {
    	return view;
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
    
    function getBestLapPace() {
    	return bestLapPace;
    }
    
    function getAvgLapPace() {
    	return avgLapPace;
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