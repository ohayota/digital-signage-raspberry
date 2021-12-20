enum Area {
  area1(90, 130), 
  area2(533, 130), 
  area3(982, 130), 
  area4(1425, 130), 
  area5(90, 560), 
  area6(533, 560), 
  area7(982, 560), 
  area8(1425, 560);
  
  private final int layoutGuideX;
  private final int layoutGuideY;
  private Area(int layoutGuideX, int layoutGuideY) {
    this.layoutGuideX = layoutGuideX;
    this.layoutGuideY = layoutGuideY;
  }
  
  public int getLayoutGuideX() {
    return layoutGuideX;
  }
  public int getLayoutGuideY() {
    return layoutGuideY;
  }
}
