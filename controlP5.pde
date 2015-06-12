ControlP5 cp5;
Slider rowsSlider, blockWidthSlider, startXScalarSlider;

CallbackListener blockWidthCallback, startXScalarCallback;

String data[];

void initControlP5() {

  data = loadStrings("alignment.txt");

  blockWidth = float(data[0]);
  startXScalar = float(data[1]);
  rows = int(data[2]);
  println("rows? "+rows);

  cp5 = new ControlP5(this);


  blockWidthCallback = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) {
        println("callback");
        data[0] = str(blockWidth);
        saveStrings("data/alignment.txt", data);
        initBlocks();
      }
    }
  };

  startXScalarCallback = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) {
        println("callback");
        data[1] = str(startXScalar);
        saveStrings("data/alignment.txt", data);
        initBlocks();
      }
    }
  };


  blockWidthSlider = cp5.addSlider("blockWidth").setRange(0, 500).setValue(blockWidth).setPosition(100, 50).addCallback(blockWidthCallback).hide();
  startXScalarSlider = cp5.addSlider("startXScalar").setPosition(100, 80).setValue(startXScalar).setRange(-1.0, 1.0).addCallback(startXScalarCallback).hide();
  rowsSlider = cp5.addSlider("rowsSliderCallback").setPosition(100, 20).setValue(rows*1.0).setRange(1, 50).hide();
}

void rowsSliderCallback(int value) {
  rows = value;
  data[2] = str(rows);
  saveStrings("data/alignment.txt", data);
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
