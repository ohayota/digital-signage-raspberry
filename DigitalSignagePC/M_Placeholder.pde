class Placeholder {
  
  PGraphics placeholder;
  
  public Placeholder() {
    this.initialize();
  }
  
  void initialize() {
    PGraphics pg = createGraphics(width, height);
  
    pg.beginDraw();
    
    pg.colorMode(HSB, 360, 100, 100, 100);
    for (Area area: Area.values()) {
      // モジュール配置エリアの左上に基準点を打つ
      pg.noStroke();
      pg.fill(0, 0, 50);
      pg.circle(area.getLayoutGuideX(), area.getLayoutGuideY(), 20);
      // モジュール配置エリアに角丸四角の枠を描く
      pg.noFill();
      pg.stroke(0, 0, 50);
      pg.strokeWeight(5);
      pg.rect(area.getLayoutGuideX(), area.getLayoutGuideY(),
              RModuleSize.S.getRModuleWidth(), RModuleSize.S.getRModuleHeight(),
              state.MODULE_RECT_ROUND);
    }
    
    pg.endDraw();
    
    this.placeholder = pg;
  }
  
  void draw() {
    push();
    
    image(this.placeholder, 0, 0);
    
    pop();
  }
  
}
