class Model {
	hidden var progress = "00:00:00";
	hidden var pace = "--:--";
    hidden var hr = "0";
    hidden var mini = false;
    
    function setProgress(p) {
    	progress = p;
    }
    
    function setPace(p) {
    	pace = p;
    }
    
    function setHr(h) {
    	hr = h;
    }
    
    function setMini(m) {
    	mini = m;
    }
    
    function getProgress() {
    	return progress;
    }
    
    function getPace() {
    	return pace;
    }
    
   function getHr() {
   		return hr;
   }
   
   function getMini() {
   		return mini;
   }
}