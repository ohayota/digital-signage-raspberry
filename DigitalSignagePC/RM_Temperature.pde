class TemperatureRModule extends RModuleClass {
  
  float roomTempValue = 20.0;
  
  final PGraphics background;
  
  //final I2C i2c;
  
  public TemperatureRModule(Area area) {
    super(RModule.Temperature, area);
    //i2c = new I2C(I2C.list()[0]);
    
    this.background = generateBackground();
    this.update();
  }
  
  PGraphics generateBackground() {
    PGraphics pg = createGraphics(w, h);
    pg.beginDraw();
    pg.colorMode(HSB, 360, 100, 100, 100);
    pg.image( pImageCut(loadImage(rModule.getPath() + "background.jpg"), CENTER, CENTER, w, h) , 0, 0);
    pg.fill(0, 0, 0, 40);
    pg.noStroke();
    pg.rect(0, 0, w, h);
    pg.endDraw();
    pg.mask( sizeToModuleMask( rModule.getSize() ) );
    return pg;
  }
  
  void update() {
    try {
      //i2c.beginTransmission(0x48);
      //i2c.write(0xC0);
      //byte[] v = i2c.read(2);
      //i2c.endTransmission();
      
      //int temp = ((v[0] & 0x1F) * 256 + (v[1] & 0xFF));
      //if (4096 <= temp) {
      //  temp -= 8192;
      //}
    
      //roomTempValue = temp * 0.0078;
      //super.isUpdated = true;
    } catch (Exception e) {
      roomTempValue = 0.0;
      super.isUpdated = false;
    }
  }
  
  void draw() {
    super.draw();
    
    push();
    
    // 背景表示
    image(this.background, x, y, w, h);
      
    // モジュールの名前表示
    drawText(LEFT, BASELINE, state.WHITE_COLOR, 32, "室温", x+50, y+50);
    
    if (super.isUpdated) {
      // 温度表示
      drawText(CENTER, BASELINE, state.WHITE_COLOR, 96, nf(roomTempValue, 0, 1)+"℃", x+w/2, y+150);
    } else {
      fill(0, 0, 0, 50);
      noStroke();
      rect(x, y, w, h, state.MODULE_RECT_ROUND);
      
      drawText(CENTER, CENTER, state.WHITE_COLOR, 24, "室温を取得できませんでした", x+w/2, y+h/2);
    }
    
    pop();
  }
  
}
