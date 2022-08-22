class BusRModule extends RModuleClass {
  final String[] keys = {"line_name", "departure_hour", "departure_minute", "is_holiday"};
  final String BUS_API_URL;
  final String BUSSTOP_START;
  final String BUSSTOP_END;
  final PImage busMap;
  
  private String title;
  private String[] lineNames;
  private int[] departureHours;
  private int[] departureMinutes;
  
  private ArrayList<String> nearly2BusTimeString;
  private ArrayList<Integer> nearly2BusRemainMinutes;
  private ArrayList<String> nearly2BusLineNames;
  
  final PGraphics background;
  
  public BusRModule(processing.data.JSONObject json) {
    super(RModule.Bus, json.getInt("PAGE_ID"), json.getInt("AREA_ID"));
    this.BUS_API_URL = json.getString("BUS_API_URL");
    this.BUSSTOP_START = json.getString("BUSSTOP_START");
    this.BUSSTOP_END = json.getString("BUSSTOP_END");
    this.background = generateBackground();
    this.update();
    this.busMap = pImageCut(loadImage(rModule.getPath() + "bus_map.jpg"), CENTER, CENTER, 1280, 720);
  }
  
  private PGraphics generateBackground() {
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
  
  private void refleshTop2() {
    nearly2BusTimeString = new ArrayList<String>();
    nearly2BusRemainMinutes = new ArrayList<Integer>();
    nearly2BusLineNames = new ArrayList<String>();
    
    int count = 0;
    for (int i = 0; i < lineNames.length; i++) {
      if (dateModule.hour == departureHours[i]) {
        // すでに出発した便は飛ばす
        if (departureMinutes[i] < dateModule.minute) continue;
        String time = nf(departureHours[i], 2) + ":" + nf(departureMinutes[i], 2);
        int remainMinute = departureMinutes[i] - dateModule.minute;
        
        nearly2BusTimeString.add(time);
        nearly2BusRemainMinutes.add(remainMinute);
        nearly2BusLineNames.add(lineNames[i]);
        count++;
      }
      if (dateModule.hour < departureHours[i]) {
        String time = nf(departureHours[i], 2) + ":" + nf(departureMinutes[i], 2);
        int remainMinute = (departureHours[i] - dateModule.hour)*60 + (departureMinutes[i] - dateModule.minute);
        
        nearly2BusTimeString.add(time);
        nearly2BusRemainMinutes.add(remainMinute);
        nearly2BusLineNames.add(lineNames[i]);
        count++;
      }
      
      // 表示する2件が揃ったらこれ以降のダイヤは見ない
      if (count == 2) break;
    }
  }
  
  public void update() {
    title = "函館バス（平日ダイヤ）";
    if (dateModule.isHoliday) title = "函館バス（土日祝ダイヤ）";
    
    try {
      processing.data.JSONArray json = loadJSONArray(this.BUS_API_URL);
      
      // 平日なら平日ダイヤ、土日祝なら土日祝ダイヤだけの数を数える
      int dataCount = 0;
      for (int row = 0; row < json.size(); row++) {
        if (json.getJSONObject(row).getBoolean(keys[3]) == dateModule.isHoliday) {
          dataCount++;
        }
      }
    
      lineNames = new String[dataCount];
      departureHours = new int[dataCount];
      departureMinutes = new int[dataCount];
      
      // JSONから系統名、時刻を取り出して保存
      int i = 0;
      for (int row = 0; row < json.size(); row++) {
        processing.data.JSONObject obj = json.getJSONObject(row);
        if (obj.getBoolean(keys[3]) == dateModule.isHoliday) {
          lineNames[i] = obj.getString(keys[0]);
          departureHours[i] = obj.getInt(keys[1]);
          departureMinutes[i] = obj.getInt(keys[2]);
          println("[" + lineNames[i] + "] " + nf(departureHours[i], 2) + ":" + nf(departureMinutes[i], 2));
          i++;
        }
      }
      
      println("updateBus(): バス時刻表を取得しました。");
      refleshTop2();
      super.isUpdated = true;
    } catch (Exception e) {
      println("updateBus(): バス時刻表を取得できませんでした。" + e);
      super.isUpdated = false;
    }
  }
  
  public void draw() {
    super.draw();
    
    push();
    
    // 背景表示
    image(this.background, x, y, w, h);
    
    drawText(LEFT, BASELINE, state.WHITE_COLOR, 32, title, x+50, y+50);
    
    if (this.isUpdated) {
      noStroke();
      fill(state.GREEN_COLOR);
      rect(x+50, y+120, w/2-100, 60);
      rect(x+w/2+50, y+120, w/2-100, 60);
      
      // 始点と終点のバス停名を表示し、間に矢印
      drawText(CENTER, BASELINE, state.WHITE_COLOR, 32, BUSSTOP_START, x+50+(w/2-100)/2, y+130);
      drawText(CENTER, BASELINE, state.WHITE_COLOR, 32, BUSSTOP_END, x+w/2+50+(w/2-100)/2, y+130);
      drawText(CENTER, BASELINE, state.WHITE_COLOR, 32, "→", x+w/2, y+130);
    
      for (int i = 0; i < nearly2BusRemainMinutes.size(); i++) {
        // 「13:00」のように発車時刻表示
        drawText(CENTER, BASELINE, state.WHITE_COLOR, 48, nearly2BusTimeString.get(i), x+50+(w/2-100)/2, y+220+70*i-16);
        // 「67系統」のように系統名表示
        drawText(CENTER, BASELINE, state.WHITE_COLOR, 32, nearly2BusLineNames.get(i), x+w/2+50+(w/2-100)/2, y+220+70*i);
        // 「30分後」のように発車までの時間（分）表示、「67系統」のように系統名表示
        drawText(CENTER, BASELINE, state.WHITE_COLOR, 32, nearly2BusRemainMinutes.get(i)+"分後", x+w/2, y+220+70*i);
        // 文字の下に白の線を表示
        strokeWeight(5);
        stroke(state.WHITE_COLOR, 50);
        line(x+50, y+255+70*i, x+w-50, y+260+70*i);
      }
  
      image(busMap, x+50, y+h-(w-100)*9.0/16.0-50, w-100, (w-100)*9.0/16.0);
    } else {
      fill(0, 0, 0, 50);
      noStroke();
      rect(x, y, w, h, state.MODULE_RECT_ROUND);
      
      drawText(CENTER, CENTER, state.WHITE_COLOR, 24, "バス時刻表を取得できませんでした", x+w/2, y+h/2);
    }
    
    pop();
  }
}
