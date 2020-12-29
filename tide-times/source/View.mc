using Toybox.WatchUi;
using Toybox.Communications;

class View extends WatchUi.View {
		 
  var service = new Service();
		
  function initialize() {
    View.initialize();
  }
  
  function onLayout( dc ) {
    View.setLayout( Rez.Layouts.MainLayout( dc ) );
  }
  
  function onUpdate( dc ) {
    var tidetimes = service.getTideTimes();
    if(tidetimes != null) {
      for( var i=0; i<4; i++ ) {
        var holyhead = View.findDrawableById( "holyhead"+i );
        var llandudno = View.findDrawableById( "llandudno"+i );
        if( holyhead has :setText ) {
          holyhead.setText( tidetimes.holyhead[i].dateTime );
        } else {
          holyhead.setTideTime( tidetimes.holyhead[i] );
        }
        if( llandudno has :setText ) {
          llandudno.setText( tidetimes.llandudno[i].dateTime );
        } else {
          llandudno.setTideTime( tidetimes.llandudno[i] );
        }
      }
    }
    View.onUpdate( dc );
  }

  function onShow() {}
  function onHide() {}
}