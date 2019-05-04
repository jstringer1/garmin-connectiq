class Model {
	hidden var error;
	hidden var progress = "00:00:00";
	hidden var hr = "0";
	hidden var pace = "--:--";
	hidden var avgPace = "--:--";
	hidden var ascent = "0000";
	hidden var grade = "00.00%";
	
	function setError(e) {
		error = e;
	}
	
	function getError() {
		return error;
	}
	
	function setProgress(p) {
		progress = p;
	}
	
	function getProgress() {
		return progress;
	}
	
	function setHr(h) {
		hr = h;
	}
	
	function getHr() {
		return hr;
	}
	
	function setPace(p) {
		pace = p;
	}
	
	function getPace() {
		return pace;
	}
	
	function setAvgPace(p) {
		avgPace = p;
	}
	
	function getAvgPace() {
		return avgPace;
	}
	
	function setAscent(a) {
		ascent = a;
	}
	
	function getAscent() {
		return ascent;
	}
	
	function setGrade(g) {
		grade = g;
	}
	
	function getGrade() {
		return grade;
	}
}