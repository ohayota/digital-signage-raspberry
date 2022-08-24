void initialize() {
  final String USER_SETTING_FILE_NAME = loadJSONObject("setting.json").getString("USER_SETTING_FILE_NAME");
  final processing.data.JSONObject USER_SETTING_JSON = loadJSONObject(USER_SETTING_FILE_NAME);
  
  dateModule = new DateModule();
  launchingScreen.setIsInitializedDates(true);
  
  final String DUMMY_PATH = "dummy/";
  dummy1080x1920 = loadImage(DUMMY_PATH + "1080x1920.jpg");
  dummy1920x1080 = loadImage(DUMMY_PATH + "1920x1080.jpg");
  dummy360x360 = loadImage(DUMMY_PATH + "360x360.jpg");
  grid = new GridModule();
  placeholder = new Placeholder();
  launchingScreen.setIsInitializedImages(true);
  
  final processing.data.JSONArray pageArray = USER_SETTING_JSON.getJSONArray("Page");
  pages = new ArrayList<Page>();
  for (int pageID = 0; pageID < pageArray.size(); pageID++) {
    pages.add( new Page(pageArray.getJSONObject(pageID)) );
  }
  launchingScreen.setIsInitializedBus(true);
  launchingScreen.setIsInitializedGomi(true);
  launchingScreen.setIsInitializedWeather(true);
  launchingScreen.setIsInitializedTwitter(true);
  
  locationModule = new LocationModule(USER_SETTING_JSON.getJSONObject("Location"));
  pageControlModule = new PageControlModule();
  progressBarModule = new ProgressBarModule(USER_SETTING_JSON.getJSONObject("ProgressBar"));
  
  delay(500);
  
  state.updateNowPageID(true);
}
