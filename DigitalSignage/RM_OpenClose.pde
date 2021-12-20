class OpenCloseRModule extends RModuleClass {
  
  boolean isOpen = true;
  
  final PGraphics background;
  final PGraphics backgroundClose;
  
  final int SWITCH_PIN;
  final String OPEN_DESCRIPTION;
  final String CLOSE_DESCRIPTION;
  
  public OpenCloseRModule(Area area, int SWITCH_PIN, String OPEN_DESCRIPTION, String CLOSE_DESCRIPTION) {
    super(RModule.OpenClose, area);
    this.SWITCH_PIN = SWITCH_PIN;
    this.OPEN_DESCRIPTION = OPEN_DESCRIPTION;
    this.CLOSE_DESCRIPTION = CLOSE_DESCRIPTION;
    
    this.background = generateBackground();
    this.backgroundClose = generateBackgroundClose();
    this.update();
    
    //GPIO.pinMode(SWITCH_PIN, GPIO.INPUT);
  }
  
  PGraphics generateBackground() {
    PGraphics pg = createGraphics(w, h);
    pg.beginDraw();
    pg.colorMode(HSB, 360, 100, 100, 100);
    pg.image( pImageCut(loadImage(rModule.getPath() + "background_open.jpg"), CENTER, CENTER, w, h) , 0, 0);
    pg.fill(0, 0, 0, 40);
    pg.noStroke();
    pg.rect(0, 0, w, h);
    pg.endDraw();
    pg.mask( sizeToModuleMask( rModule.getSize() ) );
    return pg;
  }
  
  private PGraphics generateBackgroundClose() {
    PGraphics pg = createGraphics(w, h);
    pg.beginDraw();
    pg.colorMode(HSB, 360, 100, 100, 100);
    pg.image( pImageCut(loadImage(rModule.getPath() + "background_close.jpg"), CENTER, CENTER, w, h) , 0, 0);
    pg.fill(0, 0, 0, 40);
    pg.noStroke();
    pg.rect(0, 0, w, h);
    pg.endDraw();
    pg.mask( sizeToModuleMask( rModule.getSize() ) );
    return pg;
  }
  
  void update() {
    try {
      //if (GPIO.digitalRead(SWITCH_PIN) == GPIO.LOW) {
      //  isOpen = true;
      //} else {
      //  isOpen = false;
      //}
      //super.isUpdated = true;
    } catch (Exception e) {
      super.isUpdated = false;
    }
  }
  
  void draw() {
    super.draw();
    
    push();
    
    // 背景表示
    if (isOpen) {
      image(this.background, x, y, w, h);
    } else {
      image(this.backgroundClose, x, y, w, h);
    }
    
    if (super.isUpdated) {
      if (isOpen) {
        drawText(LEFT, BASELINE, state.WHITE_COLOR, 128, "OPEN", x+50, y+50);
        drawText(LEFT, BASELINE, state.WHITE_COLOR, 32, "開店しています。", x+50, y+250);
      } else {
        drawText(LEFT, BASELINE, state.WHITE_COLOR, 128, "CLOSE", x+50, y+50);
        drawText(LEFT, BASELINE, state.WHITE_COLOR, 32, "閉店しています。\n14時から開店します。", x+50, y+250);
      }
    } else {
      fill(0, 0, 0, 50);
      noStroke();
      rect(x, y, w, h, state.MODULE_RECT_ROUND);
      
      drawText(CENTER, CENTER, state.WHITE_COLOR, 24, "開店／閉店を取得できませんでした", x+w/2, y+h/2);
    }
    
    pop();
  }
  
}
