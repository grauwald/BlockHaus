ControlP5 cp5;
Slider rowsSlider, blockHeightSlider, blockWidthSlider, startXScalarSlider;

CallbackListener blockWidthCallback, blockHeightCallback, startXScalarCallback;

String data[];
//boolean toggleValue = false;
float topLeft = 0;
float topRight = 0;
float lowerLeft = 0;
float lowerRight = 0;

Toggle topLeftToggle;
Toggle topRightToggle;
Toggle lowerLeftToggle;
Toggle lowerRightToggle;

//boolean()

void initControlP5() {

  data = loadStrings("alignment.txt");

  blockWidth = float(data[0]);
  blockHeight = float(data[1]);
  startXScalar = float(data[2]);
  rows = int(data[3]);


  cp5 = new ControlP5(this);



  blockWidthCallback = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) {
        data[0] = str(blockWidth);
        saveStrings("data/alignment.txt", data);
        initBlocks();
      }
    }
  };

  blockHeightCallback = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) {
        data[1] = str(blockHeight);
        saveStrings("data/alignment.txt", data);
        initBlocks();
      }
    }
  };

  startXScalarCallback = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      if (theEvent.getAction()==ControlP5.ACTION_BROADCAST) {
        data[2] = str(startXScalar);
        saveStrings("data/alignment.txt", data);
        initBlocks();
      }
    }
  };

  blockWidthSlider = cp5.addSlider("blockWidth").setRange(220, 270).setValue(blockWidth).setPosition(100, 70).setSize(700, 10).addCallback(blockWidthCallback).hide();
  blockHeightSlider = cp5.addSlider("blockHeight").setRange(30, 40).setValue(blockHeight).setPosition(100, 90).setSize(700, 10).addCallback(blockHeightCallback).hide();
  startXScalarSlider = cp5.addSlider("startXScalar").setPosition(100, 110).setValue(startXScalar).setRange(-2.0, 1.0).setSize(700, 10).addCallback(startXScalarCallback).hide();
  rowsSlider = cp5.addSlider("rowsSliderCallback").setPosition(100, 130).setValue(rows*1.0).setRange(1, 50).setSize(700, 10).hide();
  
  topLeftToggle = cp5.addToggle("topLeft").setPosition(100, 150).setSize(20, 20).hide();
  topRightToggle = cp5.addToggle("topRight").setPosition(130, 150).setSize(20, 20).hide();
  lowerLeftToggle = cp5.addToggle("lowerLeft").setPosition(160, 150).setSize(20, 20).hide();
  lowerRightToggle = cp5.addToggle("lowerRight").setPosition(190, 150).setSize(20, 20).hide();
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
  topLeftToggle.show();
  topRightToggle.show();
  lowerLeftToggle.show();
  lowerRightToggle.show();
}

void hideControls() {
  rowsSlider.hide();
  blockWidthSlider.hide();
  blockHeightSlider.hide();
  startXScalarSlider.hide();
  topLeftToggle.hide();
  topRightToggle.hide();
  lowerLeftToggle.hide();
  lowerRightToggle.hide();
}

