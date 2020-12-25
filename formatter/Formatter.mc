module Formatter {

	function formatPace(pace) {
    	return pace <= 0 ? "--:--" : pace.format("%02d") + ":" +((pace-Toybox.Math.floor(pace)) * 60).format("%02d");
    }

    function formatDistance(distance) {
    	return distance.format("%.2f")+" Miles";
    }
    
    function formatDistanceWithoutLabel(distance) {
    	return distance.format("%.2f");
    }
    
    function formatHr(hr) {
    	return hr.format("%d");
    }
    
    function formatDuration(duration) {
    	var hours = duration / 3600000;
    	var minutes = (duration / 60000) - (hours*60);
    	var seconds = (duration / 1000) - (hours*3600) - (minutes*60);
    	return hours.format("%02d")+":"+minutes.format("%02d")+":"+seconds.format("%02d");
    }
    
    function formatDurationShort(duration) {
    	var hours = duration / 3600000;
    	var minutes = (duration / 60000) - (hours*60);
    	var seconds = (duration / 1000) - (hours*3600) - (minutes*60);
    	if(hours > 0) {
    		return hours.format("%02d")+":"+minutes.format("%02d")+":"+seconds.format("%02d");
    	}
    	return minutes.format("%02d")+":"+seconds.format("%02d");
    }
    
    function formatGrade(grade) {
    	var gradePercent = grade * 100;
    	return gradePercent.format("%.2f")+"%";
    }
}
