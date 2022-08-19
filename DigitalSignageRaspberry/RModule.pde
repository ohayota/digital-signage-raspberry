enum RModule {
  Weather("WeatherRModule", "weather/", RModuleSize.M),
  Temperature("TemperatureRModule", "temperature/", RModuleSize.S),
  Brightness("BrightnessRModule", "brightness/", RModuleSize.S),
  Bus("BusRModule", "bus/", RModuleSize.L),
  Gomi("GomiRModule", "gomi/", RModuleSize.M),
  OpenClose("OpenCloseRModule", "openclose/", RModuleSize.M),
  Twitter("TwitterRModule", "twitter/", RModuleSize.L);
  
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
