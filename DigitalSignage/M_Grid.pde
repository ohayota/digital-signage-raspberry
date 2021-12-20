public class GridModule {
  
  private final PGraphics grid;
  
  public GridModule() {
    this.grid = generateGrid();
  }
  
  private PGraphics generateGrid() {
    PGraphics pg = createGraphics(width, height);
    pg.beginDraw();
    pg.colorMode(HSB, 360, 100, 100, 100);
    pg.stroke(0, 0, 50);
    pg.strokeWeight(3);
    // 垂直の基準線
    pg.line(Area.area1.getLayoutGuideX(), 0, Area.area1.getLayoutGuideX(), height);
    pg.line(Area.area2.getLayoutGuideX(), 0, Area.area2.getLayoutGuideX(), height);
    pg.line(Area.area3.getLayoutGuideX(), 0, Area.area3.getLayoutGuideX(), height);
    pg.line(Area.area4.getLayoutGuideX(), 0, Area.area4.getLayoutGuideX(), height);
    // 水平の基準線
    pg.line(0, Area.area1.getLayoutGuideY(), width, Area.area1.getLayoutGuideY());
    pg.line(0, Area.area5.getLayoutGuideY(), width, Area.area5.getLayoutGuideY());
    pg.endDraw();
    return pg;
  }
  
  public void draw() {
    push();
    
    image(grid, 0, 0);
    
    pop();
  }
  
}
