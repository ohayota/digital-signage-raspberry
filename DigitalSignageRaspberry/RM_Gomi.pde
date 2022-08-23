class GomiRModule extends RModuleClass {
  
  final String[] keys = {"Date(YYYY/MM/DD)", "dow", "area:2"};
  final String GOMI_API_URL;
  final String LOCATION;
  
  private String[] gomiDows = new String[7];
  private GomiTarget[] gomiTargets = new GomiTarget[7];
  
  final PGraphics background;
  
  public GomiRModule(processing.data.JSONObject json) {
    super(RModule.Gomi, json.getInt("AREA_ID"));
    this.GOMI_API_URL = json.getString("GOMI_API_URL");
    this.LOCATION = json.getString("LOCATION");
    this.background = generateBackground();
    this.initialize();
    this.update();
  }
  
  void initialize() {
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
  
  public void update() {
    gomiDows = new String[7];
    gomiTargets = new GomiTarget[7];
  
    String today = dateModule.year + "/" + nf(dateModule.month, 2) + "/" + nf(dateModule.day, 2);
    println(today);
  
    try {
      processing.data.JSONArray json = loadJSONArray(this.GOMI_API_URL);
  
      int todayRowNum = Integer.MAX_VALUE;
      for (int row = 0; row < json.size(); row++) {
        processing.data.JSONObject obj = json.getJSONObject(row);
        if (obj.getString(keys[0]).equals(today)) {
          todayRowNum = row;
          break;
        }
      }
  
      if (todayRowNum == Integer.MAX_VALUE) throw new Exception();
  
      for (int i = 0; i < 7; i++) {
        int row = todayRowNum + i;
        processing.data.JSONObject obj = json.getJSONObject(row);
        String gomiTargetString = obj.getString(keys[2]);
        switch (gomiTargetString) {
        case "燃やせるごみ":
          gomiTargets[i] = GomiTarget.Moyaseru;
          break;
        case "燃やせないごみ":
          gomiTargets[i] = GomiTarget.Moyasenai;
          break;
        case "プラスチック容器包装":
          gomiTargets[i] = GomiTarget.Plastic;
          break;
        case "缶・びん・ペットボトル":
          gomiTargets[i] = GomiTarget.CanBinPet;
          break;
        default:
          gomiTargets[i] = GomiTarget.None;
        }
        String gomiDowString = obj.getString(keys[1]);
        gomiDows[i] = gomiDowString;
        println("[" + gomiDowString + "] " + gomiTargetString);
      }
  
      println("updateGomi(): ごみカレンダーを取得しました。");
      super.isUpdated = true;
    } catch (Exception e) {
      println("updateGomi(): 本日分のごみカレンダーを取得できませんでした。" + e);
      super.isUpdated = false;
    }
  }
  
  public void draw() {
    super.draw();
    
    push();
    
    // 背景表示
    image(this.background, x, y, w, h);
    
    drawText(LEFT, BASELINE, state.WHITE_COLOR, 32, "ごみカレンダー（"+LOCATION+"）", x+50, y+50);
    drawText(LEFT, BASELINE, state.WHITE_COLOR, 16, "ごみカレンダー提供元: Code for Hakodate", x+50, y+100);
    
    if (this.isUpdated) {
      noStroke();
      textAlign(LEFT, TOP);
      // 今日の回収ごみは大きく表示する
      for (int i = 0; i <= 0; i++) {
        GomiTarget target = gomiTargets[i];
        fill(target.getHue(), target.getSat(), target.getBri());
        rect(x+50, y+150+(h-150)*i/7.0, w-100, 70);
        drawText(LEFT, BASELINE, state.BLACK_COLOR, 40, gomiDows[i]+"    "+target.getName(), x+50+10, y+160+(h-150)*i/7);
      }
      // 1日後〜3日後までの回収ごみは小さく3行で左側に表示する
      for (int i = 1; i <= 3; i++) {
        GomiTarget target = gomiTargets[i];
        fill(target.getHue(), target.getSat(), target.getBri());
        rect(x+50, y+240+(h-150)*(i-1)/7.0, (w-100)/2-20, 32);
        drawText(LEFT, BASELINE, state.BLACK_COLOR, 24, gomiDows[i]+"    "+target.getName(), x+50+10, y+242+(h-150)*(i-1)/7);
      }
      // 4日後〜6日後までの回収ごみは小さく3行で右側に表示する
      for (int i = 4; i <= 6; i++) {
        GomiTarget target = gomiTargets[i];
        fill(target.getHue(), target.getSat(), target.getBri());
        rect(x+50+(w-100)/2+20, y+240+(h-150)*(i-4)/7.0, (w-100)/2-20, 32);
        drawText(LEFT, BASELINE, state.BLACK_COLOR, 24, gomiDows[i]+"    "+target.getName(), x+50+10+(w-100)/2+20, y+242+(h-150)*(i-4)/7);
      }
    } else {
      fill(0, 0, 0, 50);
      noStroke();
      rect(x, y, w, h, state.MODULE_RECT_ROUND);
      
      drawText(CENTER, BASELINE, state.WHITE_COLOR, 24, "ごみカレンダーを取得できませんでした", x+w/2, y+h/2);
    }
    
    pop();
  }
  
}
