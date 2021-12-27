class State {
  
  private int nowPageID = -1; // -1は起動画面、0以上は各ページに対応
  final int STAY_SECOND; // 1つの画面に留まる秒数（60の約数）
  final int PAGE_ALL_COUNT; // 表示するすべての画面（ページ）の合計枚数
  final int AD_IMAGE_COUNT;
  final int MODULE_RECT_ROUND;
  
  final color WHITE_COLOR;
  final color NEARLY_WHITE_COLOR;
  final color NEARLY_GREEN_COLOR;
  final color BLACK_COLOR;
  final color LIGHT_COLOR;
  final color GRAY_COLOR;
  final color GREEN_COLOR;
  
  public State(int STAY_SECOND, int PAGE_ALL_COUNT, int AD_IMAGE_COUNT, int MODULE_RECT_ROUND) {
    this.STAY_SECOND = STAY_SECOND;
    this.PAGE_ALL_COUNT = PAGE_ALL_COUNT;
    this.AD_IMAGE_COUNT = AD_IMAGE_COUNT;
    this.MODULE_RECT_ROUND = MODULE_RECT_ROUND;
    
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
      nowPageID = (nowPageID + 1) % PAGE_ALL_COUNT;
    } else {
      nowPageID = (nowPageID + PAGE_ALL_COUNT - 1) % PAGE_ALL_COUNT;
    }
  }
  
}
