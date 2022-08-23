class BrightnessRModule extends RModuleClass {
  
  private boolean isBright = true;
  private float brightnessPercent = 0.0;
  
  final PGraphics background;
  final PGraphics backgroundNotBright;
  
  SPI spi;
  
  public BrightnessRModule(processing.data.JSONObject json) {
    super(RModule.Brightness, json.getInt("AREA_ID"));
    spi = new SPI(SPI.list()[0]);
    spi.settings(500000, SPI.MSBFIRST, SPI.MODE0);
    
    this.background = generateBackground();
    this.backgroundNotBright = generateBackgroundNotBright();
    
    this.initialize();
    this.update();
  }
  
  void initialize() {
  }
  
  private PGraphics generateBackground() {
    PGraphics pg = createGraphics(w, h);
    pg.beginDraw();
    pg.colorMode(HSB, 360, 100, 100, 100);
    pg.image( pImageCut(loadImage(rModule.getPath() + "background_bright.jpg"), CENTER, CENTER, w, h) , 0, 0);
    pg.fill(0, 0, 0, 40);
    pg.noStroke();
    pg.rect(0, 0, w, h);
    pg.endDraw();
    pg.mask( sizeToModuleMask( rModule.getSize() ) );
    return pg;
  }
  
  private PGraphics generateBackgroundNotBright() {
    PGraphics pg = createGraphics(w, h);
    pg.beginDraw();
    pg.colorMode(HSB, 360, 100, 100, 100);
    pg.image( pImageCut(loadImage(rModule.getPath() + "background_not_bright.jpg"), CENTER, CENTER, w, h) , 0, 0);
    pg.fill(0, 0, 0, 40);
    pg.noStroke();
    pg.rect(0, 0, w, h);
    pg.endDraw();
    pg.mask( sizeToModuleMask( rModule.getSize() ) );
    return pg;
  }
  
  void update() {
    try {
      byte[] out = { byte(0x68), byte(0x00) };
      byte[] in = spi.transfer(out);
      int brightnessValue = ((in[0] << 8) + in[1]) & 0x3FF;
      isBright = judgeIsBrightness(brightnessValue);
      brightnessPercent = brightnessValue * 100 / 1023.0;
      println("updateBrightness(): brightnessValue=" + brightnessValue, "isBright=" + isBright);
      super.isUpdated = true;
    } catch (Exception e) {
      super.isUpdated = false;
    }
  }
  
  private boolean judgeIsBrightness(int brightnessValue) {
    return (300 <= brightnessValue);
  }
  
  public void draw() {
    super.draw();
    
    push();
    
    // 背景表示
    if (this.isBright) {
      image(this.background, x, y, w, h);
    } else {
      image(this.backgroundNotBright, x, y, w, h);
    }
    
    drawText(LEFT, BASELINE, state.WHITE_COLOR, 32, "明るさ", x+50, y+50);
    
    if (isUpdated) {
      // 温度表示
      drawText(CENTER, BASELINE, state.WHITE_COLOR, 96, int(brightnessPercent)+"%", x+w/2, y+150);
    } else {
      fill(0, 0, 0, 50);
      noStroke();
      rect(x, y, w, h, state.MODULE_RECT_ROUND);
      
      drawText(CENTER, CENTER, state.WHITE_COLOR, 24, "明るさを取得できませんでした", x+w/2, y+h/2);
    }
    
    pop();
  }
  
}
