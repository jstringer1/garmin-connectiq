module ColourPicker {
	class ColourTriplet {
   		var background;
   		var foreground;
   		var highlight;
   		
   		function initialize(b, f, h) {
   			background = b;
   			foreground = f;
   			highlight = h;
   		}
   	
   		function getBackground() {
   			return background;
   		}
   	
   		function getHighlight() {
   			return highlight;
   		}
   	
   		function getForeground() {
   			return foreground;
   		}
	}
}