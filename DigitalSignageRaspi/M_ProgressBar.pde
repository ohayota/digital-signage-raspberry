class ProgressBarModule {
  
  final int BAR_HEIGHT;
  
  public ProgressBarModule(int BAR_HEIGHT) {
    this.BAR_HEIGHT = BAR_HEIGHT;
  }
  
  private void draw() {
    push();
    
    // 残り秒数を割合として算出（%）
    float progressRate = (dateModule.second % state.STAY_SECOND) / float(state.STAY_SECOND-1);
    noStroke();
    // 時間が経過したぶんだけ、白いバーが緑で塗りつぶされていく
    fill(state.WHITE_COLOR);
    rect(0, height-BAR_HEIGHT, width, BAR_HEIGHT);
    fill(state.GREEN_COLOR);
    rect(0, height-BAR_HEIGHT, width * progressRate, BAR_HEIGHT);
    
    pop();
  }
  
}
