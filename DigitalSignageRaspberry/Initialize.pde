void initialize() {
  final String USER_SETTING_FILE_NAME = loadJSONObject("setting.json").getString("USER_SETTING_FILE_NAME");
  final processing.data.JSONObject USER_SETTING_JSON = loadJSONObject(USER_SETTING_FILE_NAME);
  
  dateModule = new DateModule();
  launchingScreen.setIsInitializedDates(true);
  
  processing.data.JSONArray rModuleJsonArray;
  
  initializeImage();
  grid = new GridModule();
  placeholder = new Placeholder();
  launchingScreen.setIsInitializedImages(true);
  
  rModuleJsonArray = USER_SETTING_JSON.getJSONArray(RModule.Bus.getName());
  for (int i = 0; i < rModuleJsonArray.size(); i++) {
    busRModules.add(new BusRModule(rModuleJsonArray.getJSONObject(i)));
  }
  launchingScreen.setIsInitializedBus(true);
  
  rModuleJsonArray = USER_SETTING_JSON.getJSONArray(RModule.Gomi.getName());
  for (int i = 0; i < rModuleJsonArray.size(); i++) {
    gomiRModules.add(new GomiRModule(rModuleJsonArray.getJSONObject(i)));
  }
  launchingScreen.setIsInitializedGomi(true);
  
  rModuleJsonArray = USER_SETTING_JSON.getJSONArray(RModule.Weather.getName());
  for (int i = 0; i < rModuleJsonArray.size(); i++) {
    weatherRModules.add(new WeatherRModule(rModuleJsonArray.getJSONObject(i)));
  }
  launchingScreen.setIsInitializedWeather(true);
  
  rModuleJsonArray = USER_SETTING_JSON.getJSONArray(RModule.Twitter.getName());
  for (int i = 0; i < rModuleJsonArray.size(); i++) {
    twitterRModules.add(new TwitterRModule(rModuleJsonArray.getJSONObject(i)));
  }
  launchingScreen.setIsInitializedTwitter(true);
  
  // 残りの各モジュール初期化
  rModuleJsonArray = USER_SETTING_JSON.getJSONArray(RModule.Temperature.getName());
  for (int i = 0; i < rModuleJsonArray.size(); i++) {
    temperatureRModules.add(new TemperatureRModule(rModuleJsonArray.getJSONObject(i)));
  }
  
  rModuleJsonArray = USER_SETTING_JSON.getJSONArray(RModule.Brightness.getName());
  for (int i = 0; i < rModuleJsonArray.size(); i++) {
    brightnessRModules.add(new BrightnessRModule(rModuleJsonArray.getJSONObject(i)));
  }
  
  rModuleJsonArray = USER_SETTING_JSON.getJSONArray(RModule.OpenClose.getName());
  for (int i = 0; i < rModuleJsonArray.size(); i++) {
    openCloseRModules.add(new OpenCloseRModule(rModuleJsonArray.getJSONObject(i)));
  }
  
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
  
  adImage = new FullImageModule[state.AD_IMAGE_COUNT]; //<>//
  for (int i = 0; i < state.AD_IMAGE_COUNT; i++) { //<>//
    PImage ad = loadImage(AD_PATH + "ad" + i + ".jpg"); //<>//
    adImage[i] = new FullImageModule(ad);
  }
  dummy1080x1920 = loadImage(DUMMY_PATH + "1080x1920.jpg");
  dummy1920x1080 = loadImage(DUMMY_PATH + "1920x1080.jpg");
  dummy360x360 = loadImage(DUMMY_PATH + "360x360.jpg");
}
