void initialize() {
  final processing.data.JSONObject settingJSON = loadJSONObject("setting.json");
  
  dateModule = new DateModule();
  launchingScreen.setIsInitializedDates(true);
  
  initializeImage();
  grid = new GridModule();
  placeholder = new Placeholder();
  launchingScreen.setIsInitializedImages(true);
  
  busRModule = new BusRModule(
                 settingJSON.getJSONObject(RModule.Bus.getName()).getString("BUS_API_URL"),
                 settingJSON.getJSONObject(RModule.Bus.getName()).getString("BUSSTOP_START"),
                 settingJSON.getJSONObject(RModule.Bus.getName()).getString("BUSSTOP_END")
               );
  launchingScreen.setIsInitializedBus(true);
  
  gomiRModule = new GomiRModule(
                  settingJSON.getJSONObject(RModule.Gomi.getName()).getString("GOMI_API_URL"),
                  settingJSON.getJSONObject(RModule.Gomi.getName()).getString("LOCATION")
                );
  launchingScreen.setIsInitializedGomi(true);
  
  weatherRModule = new WeatherRModule(
                     settingJSON.getJSONObject(RModule.Weather.getName()).getString("WEATHER_API_KEY"),
                     settingJSON.getJSONObject(RModule.Weather.getName()).getFloat("LATITUDE"),
                     settingJSON.getJSONObject(RModule.Weather.getName()).getFloat("LONGITUDE"),
                     settingJSON.getJSONObject(RModule.Weather.getName()).getString("LOCATION")
                   );
  launchingScreen.setIsInitializedWeather(true);
  
  twitterRModule = new TwitterRModule(
                     settingJSON.getJSONObject(RModule.Twitter.getName()).getString("CONSUMER_KEY"),
                     settingJSON.getJSONObject(RModule.Twitter.getName()).getString("CONSUMER_KEY_SECRET"),
                     settingJSON.getJSONObject(RModule.Twitter.getName()).getString("ACCESS_TOKEN"),
                     settingJSON.getJSONObject(RModule.Twitter.getName()).getString("ACCESS_TOKEN_SECRET"),
                     settingJSON.getJSONObject(RModule.Twitter.getName()).getString("TWEET_ID")
                   );
  launchingScreen.setIsInitializedTwitter(true);
  
  // 残りの各モジュール初期化
  temperatureRModule = new TemperatureRModule();
  brightnessRModule = new BrightnessRModule();
  
  openCloseRModule = new OpenCloseRModule(
                       settingJSON.getJSONObject(RModule.OpenClose.getName()).getInt("SWITCH_PIN"),
                       settingJSON.getJSONObject(RModule.OpenClose.getName()).getString("OPEN_DESCRIPTION"),
                       settingJSON.getJSONObject(RModule.OpenClose.getName()).getString("CLOSE_DESCRIPTION")
                     );
  
  locationModule = new LocationModule(settingJSON.getJSONObject("LocationModule").getString("LOCATION"));
  
  pageControlModule = new PageControlModule();
  progressBarModule = new ProgressBarModule(settingJSON.getJSONObject("ProgressBarModule").getInt("BAR_HEIGHT"));
  
  delay(500);
  
  state.updateNowPageID(true);
}


void initializeImage() {
  // 画像素材読み込みのための定数パス
  final String DUMMY_PATH = "dummy/";
  final String AD_PATH = "ad/";
  
  adImage = new FullImageModule[state.AD_IMAGE_COUNT];
  for (int i = 0; i < state.AD_IMAGE_COUNT; i++) {
    PImage ad = loadImage(AD_PATH + "ad" + i + ".jpg");
    adImage[i] = new FullImageModule(ad);
  }
  dummy1080x1920 = loadImage(DUMMY_PATH + "1080x1920.jpg"); //<>//
  dummy1920x1080 = loadImage(DUMMY_PATH + "1920x1080.jpg"); //<>//
  dummy360x360 = loadImage(DUMMY_PATH + "360x360.jpg"); //<>//
}
