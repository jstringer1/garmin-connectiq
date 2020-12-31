using Toybox.WatchUi;

class Background extends WatchUi.Drawable {

  function initialize( settings ) {
    Drawable.initialize( settings );
  }
  
  function draw( dc ) {
    dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_WHITE );
    dc.clear();
  }

}

class PowerBar extends WatchUi.Drawable {

  var startAngle;
  var colourHigh;
  var colourMedium;
  var colourLow;
  var value = 1;

  function initialize( settings ) {
    self.startAngle = settings[ :startAngle ];
    self.colourHigh = settings[ :colourHigh ];
    self.colourMedium = settings[ :colourMedium ];
    self.colourLow = settings[ :colourLow ];
    Drawable.initialize( settings );
  }
  
  function setValue( value ) {
    self.value = value;
  }
  
  function draw( dc ) {
    setColour( dc );
    var maxAngle = 180 * value + startAngle;
    for( var angle=startAngle; angle<maxAngle; angle+=5 ) {
      var rads = angle*0.0174533;
      var x = 120 * Math.cos(rads) + 120;
      var y = 120 * Math.sin(rads) + 120;
      dc.fillCircle(x, y, 20);
    }
  }
  
  hidden function setColour( dc ) {
    if( value > 0.66 ) {
      dc.setColor( colourHigh, Graphics.COLOR_TRANSPARENT );
    } else if( value > 0.33 ) {
      dc.setColor( colourMedium, Graphics.COLOR_TRANSPARENT );
    } else {
      dc.setColor( colourLow, Graphics.COLOR_TRANSPARENT );
    }
  }
}