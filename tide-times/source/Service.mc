using Toybox.Application;

class Service {

  const HOLYHEAD_URL = "https://stringerj.co.uk/tide-times/station/holyhead/predictions";
  const LLANDUDNO_URL = "https://stringerj.co.uk/tide-times/station/llandudno/predictions";
  const OPTIONS = {
    :method => Communications.HTTP_REQUEST_METHOD_GET,
    :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
  };
  const UNKNOWN = [ new TideTime( "HIGH", "---"), new TideTime( "LOW", "---" ), new TideTime( "HIGH", "---"), new TideTime( "LOW", "---" ) ];
  
  function getTideTimes() {
    var holyhead = extractTodaysData( Application.Storage.getValue( "holyhead" ) );
    var llandudno = extractTodaysData( Application.Storage.getValue( "llandudno" ) );
    if( holyhead == null ) {
      Communications.makeWebRequest( HOLYHEAD_URL, {}, OPTIONS, method(:setHolyheadData) );
      holyhead = UNKNOWN;
    }
    if( llandudno == null ) {
      Communications.makeWebRequest( LLANDUDNO_URL, {}, OPTIONS, method(:setLLandudnoData) );
      llandudno = UNKNOWN;
    }
    return new TideTimes( holyhead, llandudno );
  }
  
  function setHolyheadData( code, data ) {
    if( code == 200 ) {
      Application.Storage.setValue( "holyhead", data );
    }
    if( Application.Storage.getValue( "holyhead" ) != null && Application.Storage.getValue( "llandudno" ) != null ) {
      WatchUi.requestUpdate();
    }
  }
  
  function setLLandudnoData( code, data ) {
    if( code == 200 ) {
      Application.Storage.setValue( "llandudno", data );
    }
    if( Application.Storage.getValue( "holyhead" ) != null && Application.Storage.getValue( "llandudno" ) != null ) {
      WatchUi.requestUpdate();
    }
  }
  
  hidden function extractTodaysData( data ) {
    if( data == null || data.size() < 4 ) { return null; }
    var day = Time.Gregorian.info( Time.now(), Time.FORMAT_SHORT ).day;
    for( var i=0; i<data.size()-3; i++ ) {
      if( isDateTimeOfDay( data[i]["dateTime"], day ) ) {
        return [ parseTideTime( data[i] ), parseTideTime( data[i+1] ), 
                 parseTideTime( data[i+2] ), parseTideTime( data[i+3] ) ];
      }
    }
    return null;
  }
  
  hidden function isDateTimeOfDay( dateTime, day ) {
  	return dateTime.substring( 8, 10 ).toNumber() == day.toNumber();
  }
  
  hidden function parseTideTime( data ) {
  	return new TideTime( data["type"], data["dateTime"].substring( 11, 16 ) );
  }
}