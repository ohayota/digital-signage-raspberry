enum RModuleSize {
  S(402, 400),
  M(845, 400),
  L(845, 830);
  
  private final int rModuleWidth;
  private final int rModuleHeight;
  private RModuleSize(int rModuleWidth, int rModuleHeight) {
    this.rModuleWidth = rModuleWidth;
    this.rModuleHeight = rModuleHeight;
  }
  
  public int getRModuleWidth() {
    return rModuleWidth;
  }
  public int getRModuleHeight() {
    return rModuleHeight;
  }
}
