void initialize() {
  final String USER_SETTING_FILE_NAME = loadJSONObject("setting.json").getString("USER_SETTING_FILE_NAME");
  final processing.data.JSONObject USER_SETTING_JSON = loadJSONObject(USER_SETTING_FILE_NAME);
  
  dateModule = new DateModule();
  launchingScreen.setIsInitializedDates(true);
  
  initializeImage();
  grid = new GridModule();
  placeholder = new Placeholder();
  launchingScreen.setIsInitializedImages(true); //<>//
  
  
  final processing.data.JSONArray pageArray = USER_SETTING_JSON.getJSONArray("Page");
  for (int pageID = 0; pageID < pageArray.size(); pageID++) {
    Page page = new Page();
    final processing.data.JSONObject pageObject = pageArray.getJSONObject(pageID);
    processing.data.JSONArray rmArray; 
    
    rmArray = pageObject.getJSONArray(RModule.Bus.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        BusRModule rm = new BusRModule(rmArray.getJSONObject(i));
        page.busRModules.add(rm); //<>//
      }
    }
    rmArray = pageObject.getJSONArray(RModule.Gomi.getName()); //<>//
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        GomiRModule rm = new GomiRModule(rmArray.getJSONObject(i));
        page.gomiRModules.add(rm); //<>//
      }
    }
    rmArray = pageObject.getJSONArray(RModule.Weather.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        WeatherRModule rm = new WeatherRModule(rmArray.getJSONObject(i));
        page.weatherRModules.add(rm);
      }
    }
    rmArray = pageObject.getJSONArray(RModule.Twitter.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        TwitterRModule rm = new TwitterRModule(rmArray.getJSONObject(i));
        page.twitterRModules.add(rm);
      }
    }
    rmArray = pageObject.getJSONArray(RModule.Temperature.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        TemperatureRModule rm = new TemperatureRModule(rmArray.getJSONObject(i));
        page.temperatureRModules.add(rm);
      }
    }
    rmArray = pageObject.getJSONArray(RModule.Brightness.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        BrightnessRModule rm = new BrightnessRModule(rmArray.getJSONObject(i));
        page.brightnessRModules.add(rm);
      }
    }
    rmArray = pageObject.getJSONArray(RModule.OpenClose.getName());
    if (rmArray != null) {
      for (int i = 0; i < rmArray.size(); i++) {
        OpenCloseRModule rm = new OpenCloseRModule(rmArray.getJSONObject(i));
        page.openCloseRModules.add(rm);
      }
    }
    pages.add(page);
  }
  launchingScreen.setIsInitializedBus(true);
  launchingScreen.setIsInitializedGomi(true);
  launchingScreen.setIsInitializedWeather(true);
  launchingScreen.setIsInitializedTwitter(true);
  
  locationModule = new LocationModule(USER_SETTING_JSON);
  
  pageControlModule = new PageControlModule();
  progressBarModule = new ProgressBarModule(USER_SETTING_JSON);
  
  delay(500);
  
  state.updateNowPageID(true);
}


void initializeImage() {
  // 画像素材読み込みのための定数パス
  final String DUMMY_PATH = "dummy/";
  final String AD_PATH = "ad/";
  
  adImage = new ArrayList<FullImageModule>(); //<>//
  for (int i = 0; i < 20; i++) { //<>//
    PImage ad = loadImage(AD_PATH + "ad" + i + ".jpg");
    if (ad == null) break;
    adImage.add(new FullImageModule(ad)); //<>//
  }
  dummy1080x1920 = loadImage(DUMMY_PATH + "1080x1920.jpg");
  dummy1920x1080 = loadImage(DUMMY_PATH + "1920x1080.jpg");
  dummy360x360 = loadImage(DUMMY_PATH + "360x360.jpg");
}
