class WeatherRModule extends RModuleClass {
  
  private PImage weatherIcon;
  private float temperature = 0.0;
  private int humidity = 0;
  private String weatherString = "";
  final String WEATHER_API_KEY;
  final float LATITUDE; // 自分が天気を取得したい場所の緯度
  final float LONGITUDE; // 自分が天気を取得したい場所の経度
  final String LOCATION;
  
  final PGraphics background;
  
  public WeatherRModule(processing.data.JSONObject json) {
    super(RModule.Weather, json.getInt("PAGE_ID"), json.getInt("AREA_ID"));
    this.WEATHER_API_KEY = json.getString("WEATHER_API_KEY");
    this.LATITUDE = json.getFloat("LATITUDE");
    this.LONGITUDE = json.getFloat("LONGITUDE");
    this.LOCATION = json.getString("LOCATION");
    this.background = generateBackground();
    this.update();
  }
  
  PGraphics generateBackground() {
    PGraphics pg = createGraphics(w, h);
    pg.beginDraw();
    pg.colorMode(HSB, 360, 100, 100, 100);
    pg.image( pImageCut(loadImage(rModule.getPath() + "background.jpg"), CENTER, CENTER, w, h) , 0, 0);
    pg.fill(0, 0, 0, 40);
    pg.noStroke();
    pg.rect(0, 0, w, h);
    pg.endDraw();
    pg.mask( sizeToModuleMask( rModule.getSize() ) );
    return pg;
  }
  
  private String openWeatherURL(float latitude, float longitude, String apiKey) {
    return "https://api.openweathermap.org/data/2.5/onecall?" +
           "lat=" + latitude + "&lon=" + longitude +
           "&units=metric&lang=ja&appid=" + apiKey;
  }
  
  void update() {
    try {
      // 現在の天気を取得する
      final String url = openWeatherURL(LATITUDE, LONGITUDE, WEATHER_API_KEY);
      final processing.data.JSONObject json = loadJSONObject(url);
      final processing.data.JSONObject current = json.getJSONObject("current");
      final processing.data.JSONArray weather = current.getJSONArray("weather");
      
      // 天気の説明、温度、湿度を取得
      weatherString = weather.getJSONObject(0).getString("description");
      temperature = current.getFloat("temp");
      humidity = current.getInt("humidity");
      
      // 現在の天気に対応する画像を持ってくる
      final String iconCode = weather.getJSONObject(0).getString("icon");
      weatherIcon = loadImage("http://openweathermap.org/img/wn/" + iconCode + "@2x.png");
  
      println("updateWeather(): 天気情報を取得しました。");
      super.isUpdated = true;
    } catch (Exception e) {
      println("updateWeather(): 天気情報を取得できませんでした。" + e);
      super.isUpdated = false;
    }
  }
  
  void draw() {
    super.draw();
    
    push();
    
    // 背景表示
    image(this.background, x, y, w, h);
    
    drawText(LEFT, BASELINE, state.WHITE_COLOR, 32, "現在の天気（"+LOCATION+"）", x+50, y+50);
    drawText(LEFT, BASELINE, state.WHITE_COLOR, 16, "気象データ提供元: OpenWeather(TM)", x+50, y+100);
    
    if (super.isUpdated) {
      drawText(LEFT, BASELINE, state.WHITE_COLOR, 64, int(temperature)+"℃ / "+humidity+"%", x+50, y+160);
      drawText(LEFT, BASELINE, state.WHITE_COLOR, 42, weatherString, x+50, y+260);
      image(weatherIcon, x+w-h, y+50, h, h);
    } else {
      fill(0, 0, 0, 50);
      noStroke();
      rect(x, y, w, h, state.MODULE_RECT_ROUND);
      
      drawText(CENTER, CENTER, state.WHITE_COLOR, 24, "天気データを取得できませんでした", x+w/2, y+h/2);
    }
    
    pop();
  }
  
}
