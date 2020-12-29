class TideTimes {
  var holyhead;
  var llandudno;
  
  function initialize( holyhead, llandudno ) {
    self.holyhead = holyhead;
    self.llandudno = llandudno;
  }
}

class TideTime {
  var type;
  var dateTime;
  
  function initialize( type, dateTime ) {
    self.type = type;
    self.dateTime = dateTime;
  } 
}