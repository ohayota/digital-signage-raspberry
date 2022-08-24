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
    initialize();
  }
  
  void update() {
    for (OpenCloseRModule openClose: openCloseRModules) {
      openClose.update();
    }
    for (TemperatureRModule temperature: temperatureRModules) {
      temperature.update();
    }
    for (BrightnessRModule brightness: brightnessRModules) {
      brightness.update();
    }
    
    // 日付が更新されたら実行する
    if (dateModule.isUpdatedDay) {
      dateModule.updateYoubi();
      
      for (BusRModule bus: busRModules) {
        bus.update();
      }
      for (GomiRModule gomi: gomiRModules) {
        gomi.update();
      }
    }
    
    // 1秒間隔で実行する
    if (dateModule.isUpdatedSecond) {
      if (dateModule.isUpdatedMinute) {
        for (BusRModule bus: busRModules) {
          bus.refleshTop2();
        }
      }
      if (dateModule.isUpdatedHour) {
        for (WeatherRModule weather: weatherRModules) {
          weather.update();
        }
        for (TwitterRModule twitter: twitterRModules) {
          twitter.update();
        }
      }
    }
  }
  
  void initialize() {
    String backgroundPATH = PAGE_JSON.getString("FullImage");
    background = new FullImageModule(pImageCut(loadImage(backgroundPATH), CENTER, CENTER, width, height));
    
    processing.data.JSONArray rmArray;
    
    busRModules = new ArrayList<BusRModule>();
    rmArray = PAGE_JSON.getJSONArray(RModule.Bus.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        busRModules.add( new BusRModule(rmArray.getJSONObject(i)) );
      }
    }
    
    gomiRModules = new ArrayList<GomiRModule>();
    rmArray = PAGE_JSON.getJSONArray(RModule.Gomi.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        gomiRModules.add( new GomiRModule(rmArray.getJSONObject(i)) );
      }
    }
    
    weatherRModules = new ArrayList<WeatherRModule>();
    rmArray = PAGE_JSON.getJSONArray(RModule.Weather.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        weatherRModules.add( new WeatherRModule(rmArray.getJSONObject(i)) );
      }
    }
    
    twitterRModules = new ArrayList<TwitterRModule>();
    rmArray = PAGE_JSON.getJSONArray(RModule.Twitter.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        twitterRModules.add( new TwitterRModule(rmArray.getJSONObject(i)) );
      }
    }
    
    temperatureRModules = new ArrayList<TemperatureRModule>();
    rmArray = PAGE_JSON.getJSONArray(RModule.Temperature.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        temperatureRModules.add( new TemperatureRModule(rmArray.getJSONObject(i)) );
      }
    }
    
    brightnessRModules = new ArrayList<BrightnessRModule>();
    rmArray = PAGE_JSON.getJSONArray(RModule.Brightness.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        brightnessRModules.add( new BrightnessRModule(rmArray.getJSONObject(i)) );
      }
    }
    
    openCloseRModules = new ArrayList<OpenCloseRModule>();
    rmArray = PAGE_JSON.getJSONArray(RModule.OpenClose.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        openCloseRModules.add( new OpenCloseRModule(rmArray.getJSONObject(i)) );
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
