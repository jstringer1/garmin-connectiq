using Toybox.WatchUi;

class TideTimePanel extends WatchUi.Drawable {

  hidden var tideTime;

  function initialize( settings ) {
    Drawable.initialize( settings );
  }
  
  function setTideTime( tideTime ) {
    self.tideTime = tideTime;
  }
  
  function draw( dc ) {
    if( tideTime.type.equals( "LOW" ) ) {
      dc.setColor( Graphics.COLOR_BLACK, Graphics.COLOR_BLUE );
    } else {
      dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_RED );
    }
    dc.setClip(locX, locY, width, height);
    dc.clear();
    dc.clearClip();
    dc.drawText( locX, locY, Graphics.FONT_XTINY, tideTime.dateTime, Graphics.TEXT_JUSTIFY_CENTER );
  }
}