public class DateModule {
  
  private int year;
  private int month;
  private int day;
  private int hour;
  private int minute;
  private int second;
  private int beforeDay;
  private int beforeMinute;
  private int beforeSecond;
  private boolean isHoliday;
  private Youbi youbi;
  
  public DateModule() {
    initialize();
  }
  
  void initialize() {
    updateDate();
    beforeDay = day();
    beforeSecond = second();
    // 祝日APIの値が取得できなければ、ネットワークかAPI側のどちらかの問題
    if (!updateIsHoliday()) println("DateModule.initialize(): ネットワークに接続できているか確認してください。");
    youbi = calcYoubi(year(), month(), day());
  }
  
  void updateDate() {
    year = year();
    month = month();
    day = day();
    hour = hour();
    minute = minute();
    second = second();
  }
  
  void updateBeforeDay() {
    beforeDay = day;
  }
  
  void updateBeforeMinute() {
    beforeMinute = minute;
  }
  
  void updateBeforeSecond() {
    beforeSecond = second;
  }
  
  // Zellerの公式を使った曜日計算
  Youbi calcYoubi(int year, int month, int day) {
    final Youbi[] youbi = Youbi.values();
    if (month < 3) {
      year--;
      month += 12;
    }
    return youbi[(year+year/4-year/100+year/400+(13*month+8)/5+day)%7];
  }
  
  public boolean updateIsHoliday() {
    try {
      URL url = new URL("http://s-proj.com/utils/checkHoliday.php");
      InputStream is = url.openStream();
      InputStreamReader isr = new InputStreamReader(is, "utf8");
      BufferedReader br = new BufferedReader(isr);
      isHoliday = br.readLine().equals("holiday");
    } 
    catch (Exception e) {
      println("DateModule.updateIsHoliday(): 土日祝判定を取得できませんでした。" + e);
      return false;
    }
  
    print("DateModule.updateIsHoliday(): 土日祝判定を取得しました。");
    if (isHoliday) {
      println("今日は土日祝に含まれます。");
    } else {
      println("今日は平日です。");
    }
    
    return true;
  }
  
  void draw() {
    push();
    
    blendMode(EXCLUSION);
    fill(state.WHITE_COLOR);
    textAlign(LEFT, BASELINE);
    textSize(36);
    String youbiString = youbi.getName();
    if (isHoliday && youbi.getIsWeekday()) {
      youbiString += "・祝";
    }
    String timeText = month + "月" + day + "日" + "（" + youbi.getName() + "）" + nf(hour, 2) + ":" + nf(minute, 2) + ":" + nf(second, 2);
    drawText(LEFT, BASELINE, state.WHITE_COLOR, 36, timeText, 100, 30);
    
    pop();
  }
  
}
