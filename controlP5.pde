ControlP5 cp5;
Slider rowsSlider, blockHeightSlider, blockWidthSlider, startXScalarSlider;

CallbackListener blockWidthCallback, blockHeightCallback, startXScalarCallback;

String data[];

void initControlP5() {

  data = loadStrings("alignment.txt");

  blockWidth = float(data[0]);
  blockHeight = float(data[1]);
  startXScalar = float(data[2]);
  rows = int(data[3]);

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

  blockHeightCallback = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) {
        println("callback");
        data[1] = str(blockWidth);
        saveStrings("data/alignment.txt", data);
        initBlocks();
      }
    }
  };

  startXScalarCallback = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) {
        println("callback");
        data[2] = str(startXScalar);
        saveStrings("data/alignment.txt", data);
        initBlocks();
      }
    }
  };


  blockWidthSlider = cp5.addSlider("blockWidth").setRange(0, 500).setValue(blockWidth).setPosition(100, 70).setSize(700, 40).addCallback(blockWidthCallback).hide();
  blockHeightSlider = cp5.addSlider("blockHeight").setRange(0, 100).setValue(blockHeight).setPosition(100, 120).setSize(700, 40).addCallback(blockHeightCallback).hide();
  startXScalarSlider = cp5.addSlider("startXScalar").setPosition(100, 170).setValue(startXScalar).setRange(-1.0, 1.0).setSize(700, 40).addCallback(startXScalarCallback).hide();
  rowsSlider = cp5.addSlider("rowsSliderCallback").setPosition(100, 220).setValue(rows*1.0).setRange(1, 50).setSize(700, 40).hide();
}

void rowsSliderCallback(int value) {
  rows = value;
  data[3] = str(rows);
  saveStrings("data/alignment.txt", data);
  initBlocks();
}


void renderControlP5() {
}

void showControls() {
  rowsSlider.show();
  blockWidthSlider.show();
  blockHeightSlider.show();
  startXScalarSlider.show();
}

void hideControls() {
  rowsSlider.hide();
  blockWidthSlider.hide();
  blockHeightSlider.hide();
  startXScalarSlider.hide();
}
