public class RModuleClass {
  
  protected final RModule rModule;
  protected final RModuleSize size;
  private final PGraphics shadow;
  
  protected final int x;
  protected final int y;
  protected final int w;
  protected final int h;
  
  protected boolean isUpdated;
  
  private final int SHADOW_ALPHA;
  private final int SHADOW_PADDING;
  private final int MODULE_RECT_ROUND;
  
  protected RModuleClass(RModule rModule, int areaId) {
    this.rModule = rModule;
    this.size = rModule.getSize();
    Area area = choiceArea(areaId);
    this.x = area.getLayoutGuideX();
    this.y = area.getLayoutGuideY();
    this.w = rModule.getSize().getRModuleWidth();
    this.h = rModule.getSize().getRModuleHeight();
    this.SHADOW_ALPHA = state.SHADOW_ALPHA;
    this.SHADOW_PADDING = state.SHADOW_PADDING;
    this.MODULE_RECT_ROUND = state.MODULE_RECT_ROUND;
    this.shadow = moduleShadowImage(size);
  }
  
  protected void drawModuleShadow(RModuleSize size) {
    PGraphics shadow = moduleShadowImage(size);
    image(shadow, x-SHADOW_PADDING, y-SHADOW_PADDING);
  }
  
  protected PGraphics sizeToModuleMask(RModuleSize size) {
    int w = size.getRModuleWidth();
    int h = size.getRModuleHeight();
    PGraphics moduleBackgroundMask = createGraphics(w, h);
    moduleBackgroundMask.beginDraw();
    moduleBackgroundMask.noStroke();
    moduleBackgroundMask.fill(255);
    moduleBackgroundMask.rect(0, 0, w, h, MODULE_RECT_ROUND);
    moduleBackgroundMask.endDraw();
    return moduleBackgroundMask;
  }
  
  PGraphics moduleShadowImage(RModuleSize size) {
    // 影はモジュールよりも少し大きいサイズにする
    int w = size.getRModuleWidth() + SHADOW_PADDING * 2;
    int h = size.getRModuleHeight() + SHADOW_PADDING * 2;
    
    // 影の画像を生成する
    PGraphics shadow = createGraphics(w, h);
    shadow.beginDraw();
    shadow.colorMode(HSB, 360, 100, 100, 100);
    shadow.noStroke();
    shadow.fill(0, 0, 0, SHADOW_ALPHA);
    shadow.rect(SHADOW_PADDING, SHADOW_PADDING,
                size.getRModuleWidth(), size.getRModuleHeight(),
                MODULE_RECT_ROUND);
    shadow.filter(BLUR, 8); // にじませる
    shadow.endDraw();
    
    return shadow;
  }
  
  Area choiceArea(int areaId) {
    switch (areaId) {
      case 1: 
        return Area.area1;
      case 2: 
        return Area.area2;
      case 3: 
        return Area.area3;
      case 4: 
        return Area.area4;
      case 5: 
        return Area.area5;
      case 6: 
        return Area.area6;
      case 7: 
        return Area.area7;
      case 8: 
        return Area.area8;
    }
    return null;
  }
  
  void draw() {
    push();
    image(shadow, x-SHADOW_PADDING, y-SHADOW_PADDING);
    pop();
  }
}
