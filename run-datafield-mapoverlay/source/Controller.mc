using Toybox.WatchUi;
using Toybox.Graphics;

class Controller extends WatchUi.DataField {

	hidden var service = new Service();
	hidden var model = new Model();
	hidden var view;

    function initialize() {
        DataField.initialize();
    }

    function onLayout(dc) {
    	if(dc.getWidth() >= 240) {
    		view = new FullView(model);
    		model.setMini(false);
    	} else {
    		view = new MiniView(model);
    		model.setMini(true);
    	}
        return true;
    }

    function compute(info) {
		service.updateModel(model, info);
    }

    function onUpdate(dc) {
    	view.draw(dc);
    }
}
