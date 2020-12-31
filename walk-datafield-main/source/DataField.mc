using Toybox.WatchUi;
using Toybox.Graphics;
using Gap;
using Formatter;

class DataField extends WatchUi.DataField {

  var gap = new Gap.GAP( 10 );
  var timer = "00:00:00";
  var distance = "0.00 Miles";
  var time = "00:00";
  var pace = "00:00";
  var grade = "00.00%";
  var steps = 0;
  var battery = 1;

  function initialize() {
    DataField.initialize();
  }
   
  function onLayout( dc ) {
    View.setLayout( Rez.Layouts.Walk( dc ) );
    return true;
  }
  
  function compute( info ) {
    gap.update( info );
    updateTimer( info );
    updateDistance( info );
    updateTime( info );
    pace = Formatter.formatPace( gap.getPace() );
    grade = Formatter.formatGrade( gap.getGrade() );
    updateSteps();
    battery = System.getSystemStats().battery / 100;
  }
  
  function onUpdate( dc ) {
    View.findDrawableById( "timer" ).setText( timer );
    View.findDrawableById( "distance" ).setText( distance );
    View.findDrawableById( "time" ).setText( time );
    View.findDrawableById( "pace" ).setText( pace );
    View.findDrawableById( "grade" ).setText( grade );
    View.findDrawableById( "steps" ).setValue( steps );
    View.findDrawableById( "battery" ).setValue( battery );
    View.onUpdate( dc );
  }

  hidden function updateTimer( info ) {
    if( info has :timerTime ) {
      timer = info.timerTime == null ? 0 : info.timerTime;
      timer = Formatter.formatDuration( timer );
    }
  }
  
  hidden function updateDistance( info ) {
    if( info has :elapsedDistance ) {
      distance = info.elapsedDistance == null ? 0 : (info.elapsedDistance * 0.000621371);
      distance = Formatter.formatDistance( distance );
    }
  }
  
  hidden function updateTime( info ) {
    var clockTime = System.getClockTime();
    time = Lang.format( "$1$:$2$", [clockTime.hour, clockTime.min.format( "%02d" ) ] );
  }
  
  hidden function updateSteps() {
    var info = ActivityMonitor.getInfo();
  	steps = info.steps / 1.0 / info.stepGoal;
    if(steps > 1) { steps = 1; }
  }
}