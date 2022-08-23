class Page {
  
  processing.data.JSONObject PAGE_JSON;
  
  FullImageModule background;
  
  ArrayList<WeatherRModule> weatherRModules;
  ArrayList<BusRModule> busRModules;
  ArrayList<GomiRModule> gomiRModules;
  ArrayList<TwitterRModule> twitterRModules;
  ArrayList<OpenCloseRModule> openCloseRModules;
  ArrayList<BrightnessRModule> brightnessRModules;
  ArrayList<TemperatureRModule> temperatureRModules;
  
  public Page(processing.data.JSONObject PAGE_JSON) {
    this.PAGE_JSON = PAGE_JSON;
  }
  
  void initialize() {
    String backgroundPATH = PAGE_JSON.getJSONObject("FullImage").getString("PATH");
    background = new FullImageModule(pImageCut(loadImage(backgroundPATH), CENTER, CENTER, width, height));
    
    processing.data.JSONArray rmArray;
    
    busRModules = new ArrayList<BusRModule>();
    rmArray = PAGE_JSON.getJSONArray(RModule.Bus.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        BusRModule rm = new BusRModule(rmArray.getJSONObject(i));
        busRModules.add(rm);
      }
    }
    
    gomiRModules = new ArrayList<GomiRModule>();
    rmArray = PAGE_JSON.getJSONArray(RModule.Gomi.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        GomiRModule rm = new GomiRModule(rmArray.getJSONObject(i));
        gomiRModules.add(rm);
      }
    }
    
    weatherRModules = new ArrayList<WeatherRModule>();
    rmArray = PAGE_JSON.getJSONArray(RModule.Weather.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        WeatherRModule rm = new WeatherRModule(rmArray.getJSONObject(i));
        weatherRModules.add(rm);
      }
    }
    
    twitterRModules = new ArrayList<TwitterRModule>();
    rmArray = PAGE_JSON.getJSONArray(RModule.Twitter.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        TwitterRModule rm = new TwitterRModule(rmArray.getJSONObject(i));
        twitterRModules.add(rm);
      }
    }
    
    temperatureRModules = new ArrayList<TemperatureRModule>();
    rmArray = PAGE_JSON.getJSONArray(RModule.Temperature.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        TemperatureRModule rm = new TemperatureRModule(rmArray.getJSONObject(i));
        temperatureRModules.add(rm);
      }
    }
    
    brightnessRModules = new ArrayList<BrightnessRModule>();
    rmArray = PAGE_JSON.getJSONArray(RModule.Brightness.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        BrightnessRModule rm = new BrightnessRModule(rmArray.getJSONObject(i));
        brightnessRModules.add(rm);
      }
    }
    
    openCloseRModules = new ArrayList<OpenCloseRModule>();
    rmArray = PAGE_JSON.getJSONArray(RModule.OpenClose.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        OpenCloseRModule rm = new OpenCloseRModule(rmArray.getJSONObject(i));
        openCloseRModules.add(rm);
      }
    }
  }
  
  void draw() {
    background.draw();
    //grid.draw();
    //placeholder.draw();
    
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
    
    progressBarModule.draw();
    pageControlModule.draw();
    dateModule.draw();
    locationModule.draw();
  }
  
}
