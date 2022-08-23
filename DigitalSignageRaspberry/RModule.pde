enum RModule {
  Weather("Weather", "weather/", RModuleSize.M),
  Temperature("Temperature", "temperature/", RModuleSize.S),
  Brightness("Brightness", "brightness/", RModuleSize.S),
  Bus("Bus", "bus/", RModuleSize.L),
  Gomi("Gomi", "gomi/", RModuleSize.M),
  OpenClose("OpenClose", "openclose/", RModuleSize.M),
  Twitter("Twitter", "twitter/", RModuleSize.L);
  
  private final String name;
  private final String path;
  private final RModuleSize size;
  private RModule(String name, String path, RModuleSize size) {
    this.name = name;
    this.path = path;
    this.size = size;
  }
  
  public String getName() {
    return name;
  }
  public String getPath() {
    return path;
  }
  public RModuleSize getSize() {
    return size;
  }
}
