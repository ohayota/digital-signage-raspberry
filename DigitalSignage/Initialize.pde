void initialize() {
  dateModule = new DateModule();
  launchingScreen.setIsInitializedDates(true);
  
  initializeImage();
  grid = new GridModule();
  placeholder = new Placeholder();
  launchingScreen.setIsInitializedImages(true);
  
  busRModule = new BusRModule(
                Area.area3,
                "",
                "",
                ""
              );
  launchingScreen.setIsInitializedBus(true);
  
  gomiRModule = new GomiRModule(
                 Area.area1,
                 "",
                 ""
               );
  launchingScreen.setIsInitializedGomi(true);
  
  weatherRModule = new WeatherRModule(
                    Area.area1,
                    "",
                    0.0,
                    0.0,
                    ""
                  );
  launchingScreen.setIsInitializedWeather(true);
  
  twitterRModule = new TwitterRModule(
                    Area.area3,
                    "",
                    "",
                    "",
                    "",
                    ""
                  );
  launchingScreen.setIsInitializedTwitter(true);
  
  // 残りの各モジュール初期化
  temperatureRModule = new TemperatureRModule(Area.area5);
  brightnessRModule = new BrightnessRModule(Area.area6);
  openCloseRModule = new OpenCloseRModule(
                      Area.area5,
                      23,
                      "開店しています。",
                      "閉店しています。"
                    );
  locationModule = new LocationModule("設置場所名");
  pageControlModule = new PageControlModule();
  progressBarModule = new ProgressBarModule(20);
  
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
