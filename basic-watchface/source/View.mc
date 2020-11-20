using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.ActivityMonitor;
using Toybox.Timer;

class View extends WatchUi.WatchFace {

	var sleep = true;
	var imgHeart;
	var imgHeartBig;
	var imgHeartGrey;
	var imgShoe;
	var imgShoeGrey;
	var tick = 0;
	
	var timer;

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc) {
    	imgHeart = WatchUi.loadResource(Rez.Drawables.Heart);
    	imgHeartBig = WatchUi.loadResource(Rez.Drawables.HeartBig);
    	imgHeartGrey = WatchUi.loadResource(Rez.Drawables.HeartGrey);
    	imgShoe = WatchUi.loadResource(Rez.Drawables.Shoe);
    	imgShoeGrey = WatchUi.loadResource(Rez.Drawables.ShoeGrey);
    	timer = new Timer.Timer();
    }

    function onShow() {
    }

    function onUpdate(dc) {
    	dc.clear();
    	updateBackground(dc);
    	updateDate(dc);
		updateTime(dc);
		updateHR(dc);
		updateSteps(dc);
		updateBattery(dc);
    }

    function onHide() {
    }

    function onExitSleep() {
    	sleep = false;
    	timer.start(method(:timerCallback), 200, true);
    }

    function onEnterSleep() {
    	sleep = true;
    	timer.stop();
    	tick = 0;
    }
    
    function timerCallback() {
    	tick++;
    	WatchUi.requestUpdate();
    }
    
    hidden function updateBackground(dc) {
    	if(sleep) {
    	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    	} else {
    		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
    	}
    	dc.fillRectangle(0,0,240,240);
    }
    
    hidden function updateDate(dc) {
    	var date = Time.Gregorian.info( Time.now(), Time.FORMAT_MEDIUM );
    	var dateString = Lang.format("$1$ $2$ $3$", [date.day_of_week, date.day, date.month]);
    	if(sleep) {
    		dc.setColor(0xABABAB, Graphics.COLOR_TRANSPARENT);
    	} else {
    		dc.setColor(0xFF0000, Graphics.COLOR_TRANSPARENT);
    	}
    	dc.drawText(120, 70, Graphics.FONT_MEDIUM, dateString, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    hidden function updateTime(dc) {
    	var clockTime = System.getClockTime();
    	var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
    	if(sleep) {
    		dc.setColor(0xABABAB, Graphics.COLOR_TRANSPARENT);
    	} else {
    		dc.setColor(0x0000FF, Graphics.COLOR_TRANSPARENT);
    	}
        dc.drawText(120, 120, Graphics.FONT_NUMBER_THAI_HOT, timeString, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    hidden function updateHR(dc) {
    	var hrIterator = ActivityMonitor.getHeartRateHistory(null, false);
    	var sample = hrIterator.next();
    	if( sample == null ) {
    		return;
    	}
    	while( sample.heartRate > 200 ) {
    		sample = hrIterator.next();
    	}
    	if( sample.heartRate > 200 ) {
    		return;
    	}
    	if(sleep) {
    		dc.setColor(0xABABAB, Graphics.COLOR_TRANSPARENT);
    	} else {
    		dc.setColor(0xFF0000, Graphics.COLOR_TRANSPARENT);
    	}
    	if(sleep) {
    		dc.drawBitmap(87, 192, imgHeartGrey);
    	} else if(isBigHeartTick()) {
    		dc.drawBitmap(85, 190, imgHeartBig);
    	} else {
    		dc.drawBitmap(87, 192, imgHeart);
    	}
    	dc.drawText(115, 200, Graphics.FONT_MEDIUM, sample.heartRate, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    hidden function updateSteps(dc) {
    	var info = ActivityMonitor.getInfo();
    	if(sleep) {
    		dc.setColor(0xABABAB, Graphics.COLOR_TRANSPARENT);
    	} else {
        	dc.setColor(0xFF0000, Graphics.COLOR_TRANSPARENT);
        }
    	dc.drawText(115, 170, Graphics.FONT_MEDIUM, info.steps, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
    	if(sleep) {
    		dc.drawBitmap(85, 160, imgShoeGrey);
    	} else {
    		dc.drawBitmap(85, 160, imgShoe);
    	}
    	if(sleep) {
    		return;
    	}
    	var percent = info.steps / 1.0 / info.stepGoal;
    	if(percent > 1) {
    		percent = 1;
    	}
    	drawPowerBar(dc, 90, percent, Graphics.COLOR_PURPLE);
    }
    
    hidden function updateBattery(dc) {
    	if(sleep) {
    		return;
    	}
    	var battery = System.getSystemStats().battery / 100;
    	var colour = Graphics.COLOR_RED;
    	if(battery > 0.666) {
    		colour = Graphics.COLOR_GREEN;
    	} else if(battery > 0.333) {
    		colour = Graphics.COLOR_YELLOW;
    	}
    	drawPowerBar(dc, 270, battery, colour);
    }
    
    hidden function drawPowerBar(dc, startingAngle, percent, colour) {
    	dc.setColor(colour, Graphics.COLOR_TRANSPARENT);
        var maxAngle = tick/10.0*180;
    	if(maxAngle > 180) {
    		maxAngle = 180;
    	}
    	maxAngle *= percent;
    	maxAngle += startingAngle;
    	for(var angle=startingAngle; angle<maxAngle; angle+=5) {
    		var rads = angle*0.0174533;
    		var x = 120 * Math.cos(rads) + 120;
    		var y = 120 * Math.sin(rads) + 120;
    		dc.fillCircle(x, y, 20);
    	}
    }
    
    hidden function isBigHeartTick() {
    	var remainder = tick;
    	while(remainder > 3) {
    		remainder -= 3;
    	}
    	return (remainder == 3);
    }
}