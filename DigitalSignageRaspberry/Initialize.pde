void initialize() {
  final String USER_SETTING_FILE_NAME = loadJSONObject("setting.json").getString("USER_SETTING_FILE_NAME");
  final processing.data.JSONObject USER_SETTING_JSON = loadJSONObject(USER_SETTING_FILE_NAME);
  
  dateModule = new DateModule();
  launchingScreen.setIsInitializedDates(true);
  
  initializeImage();
  grid = new GridModule();
  placeholder = new Placeholder();
  launchingScreen.setIsInitializedImages(true);
  
  busRModule = new BusRModule(USER_SETTING_JSON);
  launchingScreen.setIsInitializedBus(true);
  
  gomiRModule = new GomiRModule(USER_SETTING_JSON);
  launchingScreen.setIsInitializedGomi(true);
  
  weatherRModule = new WeatherRModule(USER_SETTING_JSON);
  launchingScreen.setIsInitializedWeather(true);
  
  twitterRModule = new TwitterRModule(USER_SETTING_JSON);
  launchingScreen.setIsInitializedTwitter(true);
  
  // 残りの各モジュール初期化
  temperatureRModule = new TemperatureRModule();
  brightnessRModule = new BrightnessRModule();
  
  openCloseRModule = new OpenCloseRModule(USER_SETTING_JSON);
  
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
