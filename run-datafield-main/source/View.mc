using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using ColourPicker;
using Formatter;

class View extends WatchUi.Drawable {

	hidden var model;

    function initialize() {
        Drawable.initialize( { :identifier => "View" } );
    }

	function setModel( model ) {
		self.model = model;
	}

    function draw( dc ) {
    	drawBackground( dc );
    	drawTimer( dc );
    	drawDistanceOrNavigation( dc );
		drawPace( dc );
		drawHR( dc );
		drawSeperators( dc );
    }
    
    hidden function drawBackground( dc ) {
    	dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_WHITE );
    	dc.clear();
    }
    
    hidden function drawTimer( dc ) {
		dc.setColor( Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT );
		dc.drawText( 120, 8, Graphics.FONT_MEDIUM, Formatter.formatDuration( model.timer ), Graphics.TEXT_JUSTIFY_CENTER );
    }
    
    hidden function drawDistanceOrNavigation( dc ) {
    	var colour = ColourPicker.calculateColoursForDistance( model.distance );
    	dc.setColor( colour.getBackground(), Graphics.COLOR_TRANSPARENT );
    	dc.fillRectangle (0, 56, 240, 50 );
    	dc.setColor( colour.getHighlight(), Graphics.COLOR_TRANSPARENT );
    	dc.fillRectangle( 0, 56, ( 240 * ( model.distance - model.distance.toLong() ) ), 50 );
		dc.setColor( colour.getForeground(), Graphics.COLOR_TRANSPARENT );
    	if( model.next == null ) {
			dc.drawText( 120, 65, Graphics.FONT_MEDIUM, Formatter.formatDistance( model.distance ), Graphics.TEXT_JUSTIFY_CENTER );
		} else {
			dc.drawText( 120, 65, Graphics.FONT_MEDIUM, model.next, Graphics.TEXT_JUSTIFY_CENTER );
		}
    }
    
    hidden function drawPace( dc ) {
    	drawUnadjustedPace( dc );
    	drawGAP( dc );
    }
    
    hidden function drawUnadjustedPace( dc ) {
    	var colours = ColourPicker.calculateColorsForPace( model.gap.getPace() );
    	dc.setColor( colours.getBackground(), Graphics.COLOR_TRANSPARENT );
    	dc.fillRectangle( 122, 111, 118, 84 );
    	dc.setColor( colours.getForeground(), Graphics.COLOR_TRANSPARENT );
    	dc.drawText( 180, 120, Graphics.FONT_LARGE, Formatter.formatPace( model.gap.getPace() ), Graphics.TEXT_JUSTIFY_CENTER );
    	colours = ColourPicker.calculateColorsForPace( model.avgPace );
		dc.setColor( colours.getBackground(), Graphics.COLOR_TRANSPARENT );
		dc.fillRectangle( 115, 165, 70, 30 );    			
		dc.setColor( colours.getForeground(), Graphics.COLOR_TRANSPARENT );
		dc.drawText( 150, 165, Graphics.FONT_XTINY, Formatter.formatPace( model.avgPace ), Graphics.TEXT_JUSTIFY_CENTER );
    }
    
    hidden function drawGAP( dc ) {
    	var colours = ColourPicker.calculateColorsForPace( model.gap.getGAP() );
    	dc.setColor( colours.getBackground(), Graphics.COLOR_TRANSPARENT );
    	dc.fillRectangle( 0, 111, 120, 84 );
		dc.setColor( colours.getForeground(), Graphics.COLOR_TRANSPARENT );
		dc.drawText( 60, 120, Graphics.FONT_LARGE, Formatter.formatPace( model.gap.getGAP() ), Graphics.TEXT_JUSTIFY_CENTER );
		colours = ColourPicker.calculateColoursForGrade( model.gap.getGrade() );
		dc.setColor( colours.getBackground(), Graphics.COLOR_TRANSPARENT );
		dc.fillRectangle( 55, 165, 70, 30 );
		dc.setColor( colours.getForeground(), Graphics.COLOR_TRANSPARENT );
		dc.drawText( 90, 165, Graphics.FONT_XTINY, Formatter.formatGrade( model.gap.getGrade() ), Graphics.TEXT_JUSTIFY_CENTER );
    }
    
    hidden function drawHR( dc ) {
    	var colours = ColourPicker.calculateColoursForHr( model.hr );
    	dc.setColor( colours.getBackground(), Graphics.COLOR_TRANSPARENT );
    	dc.fillRectangle( 0, 195, 240, 45 );
		dc.setColor( colours.getForeground(), Graphics.COLOR_TRANSPARENT );
		dc.drawText( 120, 198, Graphics.FONT_LARGE, Formatter.formatHr( model.hr ), Graphics.TEXT_JUSTIFY_CENTER );
    }
    
    hidden function drawSeperators( dc ) {
    	dc.setColor( Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT );
    	dc.fillRectangle( 0, 55, 240, 5 );
    	dc.fillRectangle( 0, 106, 240, 5 );
    	dc.fillRectangle( 0, 195, 240, 5 );
    	dc.fillRectangle( 120, 106, 5, 90 );
    }
}
