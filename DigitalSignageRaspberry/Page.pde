class Page {
  
  ArrayList<WeatherRModule> weatherRModules;
  ArrayList<BusRModule> busRModules;
  ArrayList<GomiRModule> gomiRModules;
  ArrayList<TwitterRModule> twitterRModules;
  ArrayList<OpenCloseRModule> openCloseRModules;
  ArrayList<BrightnessRModule> brightnessRModules;
  ArrayList<TemperatureRModule> temperatureRModules;
  
  public Page() {
    weatherRModules = new ArrayList<WeatherRModule>();
    busRModules = new ArrayList<BusRModule>();
    gomiRModules = new ArrayList<GomiRModule>();
    twitterRModules = new ArrayList<TwitterRModule>();
    openCloseRModules = new ArrayList<OpenCloseRModule>();
    brightnessRModules = new ArrayList<BrightnessRModule>();
    temperatureRModules = new ArrayList<TemperatureRModule>();
  }
  
  void draw() {
    for (WeatherRModule weather: weatherRModules) {
      weather.draw();
    }
    for (BusRModule bus: busRModules) {
      bus.draw();
    }
    for (GomiRModule gomi: gomiRModules) {
      gomi.draw();
    }
    for (TwitterRModule twitter: twitterRModules) {
      twitter.draw();
    }
    for (OpenCloseRModule openClose: openCloseRModules) {
      openClose.draw();
    }
    for (BrightnessRModule brightness: brightnessRModules) {
      brightness.draw();
    }
    for (TemperatureRModule temperature: temperatureRModules) {
      temperature.draw();
    }
  }
  
}
