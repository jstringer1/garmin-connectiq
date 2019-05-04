using Toybox.WatchUi;
using Toybox.Graphics;

class Controller extends WatchUi.DataField {

    hidden var service = new Service();
    hidden var model = new Model();

	function initialize() {
		DataField.initialize();
	}

    function onLayout(dc) {
    	if(dc.getWidth() < 240 || dc.getHeight() < 240) {
    		model.setError("TOO SMALL");
    		View.setLayout(Rez.Layouts.ErrorLayout(dc));
    	} else {
    		model.setError(null);
        	View.setLayout(Rez.Layouts.MainLayout(dc));
        }
        return true;
    }

    function compute(info) {
    	service.updateModel(model, info);
    }

    function onUpdate(dc) {
    	if(model.getError() != null) {
    		View.findDrawableById("error_value").setText(model.getError());
    	} else {
        	View.findDrawableById("view").setModel(model);
		}
        View.onUpdate(dc);
    }

}
