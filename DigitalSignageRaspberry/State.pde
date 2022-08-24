class State {
  
  private int nowPageID = -1; // -1は起動画面、0以上は各ページに対応
  final int STAY_SECOND; // 1つの画面に留まる秒数（60の約数）
  final int SHADOW_ALPHA;
  final int SHADOW_PADDING;
  final int MODULE_RECT_ROUND;
  
  final color WHITE_COLOR;
  final color NEARLY_WHITE_COLOR;
  final color NEARLY_GREEN_COLOR;
  final color BLACK_COLOR;
  final color LIGHT_COLOR;
  final color GRAY_COLOR;
  final color GREEN_COLOR;
  
  public State() {
    processing.data.JSONObject json = loadJSONObject("setting.json").getJSONObject("State");
    
    this.STAY_SECOND = json.getInt("STAY_SECOND");
    this.SHADOW_ALPHA = json.getInt("SHADOW_ALPHA");
    this.SHADOW_PADDING = json.getInt("SHADOW_PADDING");
    this.MODULE_RECT_ROUND = json.getInt("MODULE_RECT_ROUND");
    
    WHITE_COLOR = color(0, 0, 100);
    NEARLY_WHITE_COLOR = color(100, 2, 98);
    NEARLY_GREEN_COLOR = color(100, 5, 98);
    BLACK_COLOR = color(0, 0, 0);
    LIGHT_COLOR = color(0, 0, 80);
    GRAY_COLOR = color(0, 0, 50);
    GREEN_COLOR = color(150, 100, 60);
  }
  
  public int getNowPageID() {
    return nowPageID;
  }
  
  public void setNowPageID(int id) {
    this.nowPageID = id;
  }
  
  public void updateNowPageID(boolean isIncrement) {
    if (isIncrement) {
      nowPageID = (nowPageID + 1) % pages.size();
    } else {
      nowPageID = (nowPageID + pages.size() - 1) % pages.size();
    }
  }
  
}
