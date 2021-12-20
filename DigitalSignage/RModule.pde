enum RModule {
  Weather("weather/", RModuleSize.M),
  Temperature("temperature/", RModuleSize.S),
  Brightness("brightness/", RModuleSize.S),
  Bus("bus/", RModuleSize.L),
  Gomi("gomi/", RModuleSize.M),
  OpenClose("openclose/", RModuleSize.M),
  Twitter("twitter/", RModuleSize.L);
  
  private final String path;
  private final RModuleSize size;
  private RModule(String path, RModuleSize size) {
    this.path = path;
    this.size = size;
  }
  
  public String getPath() {
    return path;
  }
  public RModuleSize getSize() {
    return size;
  }
}
