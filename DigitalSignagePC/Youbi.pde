enum Youbi {
  Sun("日", false),
  Mon("月", true),
  Tue("火", true),
  Wed("水", true),
  Thu("木", true),
  Fri("金", true),
  Sat("土", false);
  
  private final String name;
  private final boolean isWeekday;
  private Youbi(String name, boolean isWeekday) {
    this.name = name;
    this.isWeekday = isWeekday;
  }
  
  public String getName() {
    return name;
  }
  public boolean getIsWeekday() {
    return isWeekday;
  }
}
