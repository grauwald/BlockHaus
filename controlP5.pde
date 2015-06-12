ControlP5 cp5;
Slider rowsSlider, blockWidthSlider, startXScalarSlider;

CallbackListener blockWidthCallback, rowsCallback;



void initControlP5() {

  cp5 = new ControlP5(this);

  rowsCallback = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) {
        println("callback");
        initBlocks();
      }
    }
  };
  
  blockWidthCallback = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) {
        println("callback");
        initBlocks();
      }
    }
  };

  blockWidthSlider = cp5.addSlider("blockWidth").setRange(0, 500).setPosition(100, 50).setValue(250.0).addCallback(blockWidthCallback).hide();
  startXScalarSlider = cp5.addSlider("startXScalar").setPosition(100, 80).setRange(-1.0, 1.0).setValue(-0.5).addCallback(rowsCallback).hide();
  rowsSlider = cp5.addSlider("rowsSliderCallback").setPosition(100, 20).setRange(1, 50).setValue(29).hide();
}

void rowsSliderCallback(int value) {
  rows = value;
  initBlocks();
}


void renderControlP5() {
}

void showControls() {
  rowsSlider.show();
  blockWidthSlider.show();
  startXScalarSlider.show();
}

void hideControls() {
  rowsSlider.hide();
  blockWidthSlider.hide();
  startXScalarSlider.hide();
}
