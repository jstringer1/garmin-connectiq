module ColourPicker {
	class ColourPair {
   		var background;
   		var foreground;
   	
   		function initialize(b, f) {
   			background = b;
   			foreground = f;
   		}
   	
   		function getBackground() {
   			return background;
   		}
   	
   		function getForeground() {
   			return foreground;
   		}
	}
}