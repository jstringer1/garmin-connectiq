module Gap {

	const GRADE_ADJUSTMENT = [ [-0.3, 1.5], [-0.28, 1.4], [-0.24, 1.2], [-0.2, 1.1], [-0.18, 1], [-0.16, 0.9], [-0.1, 0.85], [-0.04, 0.9], 
							   [0, 1], [0.04, 1.1], [0.06, 1.2], [0.08, 1.3], [0.1, 1.5], [0.12, 1.6], [0.14, 1.8], [0.17, 2], [0.2, 2.3], 
							   [0.24, 2.6], [0.28, 3], [0.32, 3.4] ];

	function adjustPaceForGrade( pace, grade ) {
		return pace / calculateAdjustmentForGrade( grade );
	}

	function calculateAdjustmentForGrade( grade ) {
		if( grade <= GRADE_ADJUSTMENT[0][0] ) { return GRADE_ADJUSTMENT[0][1]; }
		for( var i = 1; i<20; i++ ) {
			if( grade > GRADE_ADJUSTMENT[i-1][0] && grade <= GRADE_ADJUSTMENT[i][0] ) {
				var gradeRange = GRADE_ADJUSTMENT[i][0] - GRADE_ADJUSTMENT[i-1][0];
				var adjustmentRange = GRADE_ADJUSTMENT[i][1] - GRADE_ADJUSTMENT[i-1][1];
				var adjustment = GRADE_ADJUSTMENT[i][0] - grade;
				adjustment = gradeRange - adjustment;
				adjustment = adjustment / gradeRange;
				adjustment = adjustment * adjustmentRange;
				adjustment = adjustment + GRADE_ADJUSTMENT[i-1][1];
				return adjustment;
			}
		}
		return GRADE_ADJUSTMENT[19][1];
	}

	class GAP {
		hidden var distance = 0;
		hidden var altitude = 0;
		hidden var currentGrade = 0;
		hidden var currentPace = 0;
		hidden var currentGAP = 0;
		hidden var grade;
		hidden var pace;

		function initialize( size ) {
			grade = new RollingAvg( size );
			pace = new RollingAvg( size );
		}
		
		function getGrade() {
			return currentGrade;
		}
		
		function getPace() {
			return currentPace;
		}
		
		function getGAP() {
			return currentGAP;
		}
		
		function update( info ) {
			if( !infoIsValid( info ) ) { return; }
			var altitudeChange = info.altitude - altitude;
			var distanceChange = info.elapsedDistance - distance;
			if( distanceChange > 0 ) {
				var grade = altitudeChange / distanceChange;
				var pace = speedInKmToPaceInMiles( info.currentSpeed );
				self.grade.add( grade );
				self.pace.add( pace );
			}
			distance = info.elapsedDistance;
			altitude = info.altitude;
			currentGrade = grade.get();
			currentPace = pace.get();
			currentGAP = adjustPaceForGrade( currentPace, currentGrade );
		}
		
		hidden function infoIsValid( info ) {
			if( info == null ) { return false; }
			if( !(info has :altitude ) || info.altitude == null ) { return false; }
			if( !(info has :elapsedDistance ) || info.elapsedDistance == null || info.elapsedDistance == 0 ) { return false; }
			if( !(info has :currentSpeed ) || info.currentSpeed == null || info.currentSpeed == 0 ) { return false; }
			return true;
		}
		
		hidden function speedInKmToPaceInMiles( speed ) {
			return 60 / ( speed * 2.2369356 );
		}
	}
	
	class RollingAvg {
		hidden var size;
		hidden var data;
		hidden var pointer = 0;
	
		function initialize( size ) {
			self.size = size;
			self.data = new[size];
		}
	
		function add( value ) {
			data[pointer] = value;
    		pointer = (pointer + 1) % size;
		}
	
		function get() {
			var sum = 0.0;
			var values = 0;
			for( var i = 0; i < size; i++ ) {
				if(data[i] != null) {
					values++;
					sum += data[i];
				}
			}
			return values == 0 ? 0 : ( sum / values );
		}
	}
}