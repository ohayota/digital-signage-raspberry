// TEST_MODE=trueのときに実行されるテスト用関数

void test() {
  println("[ TEST MODE ]");
  
  initialize();
  
  testCalcYoubi();
  testLayoutGuideX();
  testLayoutGuideY();
  testModuleWidth();
  testModuleHeight();
  testModuleSize();
  testPImageToSquare();
  testPImageCut();
  testUpdateNowPageID();
  testJudgeIsBrightness();
  
  println("All tests were successful!!");
}


void testCalcYoubi() {
  Youbi y;
  
  y = dateModule.calcYoubi(2021, 10, 3);
  assert (y == Youbi.Sun) : "Not equal Youbi.Sun: " + y;
  
  y = dateModule.calcYoubi(2021, 10, 4);
  assert (y == Youbi.Mon) : "Not equal Youbi.Mon: " + y;
  
  y = dateModule.calcYoubi(2021, 10, 5);
  assert (y == Youbi.Tue) : "Not equal Youbi.Tue: " + y;
  
  y = dateModule.calcYoubi(2021, 10, 6);
  assert (y == Youbi.Wed) : "Not equal Youbi.Wed: " + y;
  
  y = dateModule.calcYoubi(2021, 10, 7);
  assert (y == Youbi.Thu) : "Not equal Youbi.Thu: " + y;
  
  y = dateModule.calcYoubi(2021, 10, 8);
  assert (y == Youbi.Fri) : "Not equal Youbi.Fri: " + y;
  
  y = dateModule.calcYoubi(2021, 10, 9);
  assert (y == Youbi.Sat) : "Not equal Youbi.Sat: " + y;
  
  println("Test passed: testCalcYoubi()");
}


void testJudgeIsBrightness() {
  boolean b;
  
  b = brightnessRModule.judgeIsBrightness(299);
  assert (b == false) : "Not equal false: " + b;
  
  b = brightnessRModule.judgeIsBrightness(300);
  assert (b == true) : "Not equal true: " + b;
  
  println("Test passed: testJudgeIsBrightness()");
}


void testLayoutGuideX() {
  int x;
  
  x = Area.area1.getLayoutGuideX();
  assert (x == 90) : "Not equal 90: " + x;
  
  x = Area.area2.getLayoutGuideX();
  assert (x == 533) : "Not equal 533: " + x;
  
  x = Area.area3.getLayoutGuideX();
  assert (x == 982) : "Not equal 982: " + x;
  
  x = Area.area4.getLayoutGuideX();
  assert (x == 1425) : "Not equal 1425: " + x;
  
  x = Area.area5.getLayoutGuideX();
  assert (x == 90) : "Not equal 90: " + x;
  
  x = Area.area6.getLayoutGuideX();
  assert (x == 533) : "Not equal 533: " + x;
  
  x = Area.area7.getLayoutGuideX();
  assert (x == 982) : "Not equal 982: " + x;
  
  x = Area.area8.getLayoutGuideX();
  assert (x == 1425) : "Not equal 1425: " + x;
  
  println("Test passed: testLayoutGuideX()");
}


void testLayoutGuideY() {
  int y;
  
  y = Area.area1.getLayoutGuideY();
  assert (y == 130) : "Not equal 130: " + y;
  
  y = Area.area2.getLayoutGuideY();
  assert (y == 130) : "Not equal 130: " + y;
  
  y = Area.area3.getLayoutGuideY();
  assert (y == 130) : "Not equal 130: " + y;
  
  y = Area.area4.getLayoutGuideY();
  assert (y == 130) : "Not equal 130: " + y;
  
  y = Area.area5.getLayoutGuideY();
  assert (y == 560) : "Not equal 560: " + y;
  
  y = Area.area6.getLayoutGuideY();
  assert (y == 560) : "Not equal 560: " + y;
  
  y = Area.area7.getLayoutGuideY();
  assert (y == 560) : "Not equal 560: " + y;
  
  y = Area.area8.getLayoutGuideY();
  assert (y == 560) : "Not equal 560: " + y;
  
  println("Test passed: testLayoutGuideY()");
}


void testModuleWidth() {
  assert (RModuleSize.S.getRModuleWidth() == 402) : "ERROR";
  assert (RModuleSize.M.getRModuleWidth() == 845) : "ERROR";
  assert (RModuleSize.L.getRModuleWidth() == 845) : "ERROR";
  
  println("Test passed: testModuleWidth()");
}


void testModuleHeight() {
  assert (RModuleSize.S.getRModuleHeight() == 400) : "ERROR";
  assert (RModuleSize.M.getRModuleHeight() == 400) : "ERROR";
  assert (RModuleSize.L.getRModuleHeight() == 830) : "ERROR";
  
  println("Test passed: testModuleHeight()");
}


void testModuleSize() {
  RModuleSize size;
  
  size = RModule.Weather.getSize();
  assert (size == RModuleSize.M) : "Not equal Size.M: " + size;
  
  size = RModule.Temperature.getSize();
  assert (size == RModuleSize.S) : "Not equal Size.S: " + size;
  
  size = RModule.Brightness.getSize();
  assert (size == RModuleSize.S) : "Not equal Size.S: " + size;
  
  size = RModule.Bus.getSize();
  assert (size == RModuleSize.L) : "Not equal Size.L: " + size;
  
  size = RModule.Gomi.getSize();
  assert (size == RModuleSize.M) : "Not equal Size.M: " + size;
  
  size = RModule.OpenClose.getSize();
  assert (size == RModuleSize.M) : "Not equal Size.M: " + size;
  
  size = RModule.Twitter.getSize();
  assert (size == RModuleSize.L) : "Not equal Size.L: " + size;
  
  println("Test passed: testModuleSize()");
}


void testPImageToSquare() {
  PImage square;
  
  square = pImageToSquare(dummy1080x1920, TOP);
  assert (square.width == 1080) : "Not equal 1080: " + square.width;
  assert (square.height == 1080) : "Not equal 1080: " + square.height;
  
  square = pImageToSquare(dummy1080x1920, CENTER);
  assert (square.width == 1080) : "Not equal 1080: " + square.width;
  assert (square.height == 1080) : "Not equal 1080: " + square.height;
  
  square = pImageToSquare(dummy1080x1920, BOTTOM);
  assert (square.width == 1080) : "Not equal 1080: " + square.width;
  assert (square.height == 1080) : "Not equal 1080: " + square.height;
  
  square = pImageToSquare(dummy1920x1080, LEFT);
  assert (square.width == 1080) : "Not equal 1080: " + square.width;
  assert (square.height == 1080) : "Not equal 1080: " + square.height;
  
  square = pImageToSquare(dummy1920x1080, CENTER);
  assert (square.width == 1080) : "Not equal 1080: " + square.width;
  assert (square.height == 1080) : "Not equal 1080: " + square.height;
  
  square = pImageToSquare(dummy1920x1080, RIGHT);
  assert (square.width == 1080) : "Not equal 1080: " + square.width;
  assert (square.height == 1080) : "Not equal 1080: " + square.height;
  
  println("Test passed: testPImageToSquare()");
}


void testPImageCut() {
  int afterWidth = 1080;
  int afterHeight = 720;
  PImage cut;
  
  int[] modeX = {LEFT, CENTER, RIGHT};
  int[] modeY = {TOP, CENTER, BOTTOM};
  
  for (int ix = 0; ix < modeX.length; ix++) {
    for (int iy = 0; iy < modeY.length; iy++) {
      cut = pImageCut(dummy1920x1080, modeX[ix], modeY[iy], afterWidth, afterHeight);
      assert (cut.width == afterWidth) : "Not equal " + afterWidth + ": " + cut.width;
      assert (cut.height == afterHeight) : "Not equal " + afterHeight + ": " + cut.height;
    }
  }
  
  afterWidth = 720;
  afterHeight = 1080;
  
  for (int ix = 0; ix < modeX.length; ix++) {
    for (int iy = 0; iy < modeY.length; iy++) {
      cut = pImageCut(dummy1920x1080, modeX[ix], modeY[iy], afterWidth, afterHeight);
      assert (cut.width == afterWidth) : "Not equal " + afterWidth + ": " + cut.width;
      assert (cut.height == afterHeight) : "Not equal " + afterHeight + ": " + cut.height;
    }
  }
  
  println("Test passed: testPImageCut()");
}


void testUpdateNowPageID() {
  state.setNowPageID(0);
  state.updateNowPageID(true);
  assert (state.getNowPageID() == 1) : "Not equal 1: " + state.getNowPageID();
  
  state.setNowPageID(0);
  state.updateNowPageID(false);
  assert (state.getNowPageID() == (state.PAGE_ALL_COUNT-1)) : "Not equal " + (state.PAGE_ALL_COUNT-1) + ": " + state.getNowPageID();
  
  
  state.setNowPageID(state.PAGE_ALL_COUNT-1);
  state.updateNowPageID(false);
  assert (state.getNowPageID() == (state.PAGE_ALL_COUNT-2)) : "Not equal " + (state.PAGE_ALL_COUNT-2) + ": " + state.getNowPageID();
  
  state.setNowPageID(state.PAGE_ALL_COUNT-1);
  state.updateNowPageID(true);
  assert (state.getNowPageID() == 0) : "Not equal 0: " + state.getNowPageID();
  
  println("Test passed: testUpdateNowPageID()");
}
