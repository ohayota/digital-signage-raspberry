class PageControlModule {
  
  public PageControlModule() {
  }
  
  void draw() {
    push();
    
    float y = 1020;
    for (int page = 0; page < pages.size(); page++) {
      // ページ番号をもとに点を横に並べる
      float x = width/2 + 30 * (page-(pages.size()-1)/2.0);
      // 現在のページだけ白、それ以外は緑の点を打つ
      if (page == state.getNowPageID()) {
        fill(state.WHITE_COLOR);
        stroke(state.GREEN_COLOR);
        strokeWeight(5);
        circle(x, y, 20);
      } else {
        fill(state.GREEN_COLOR);
        noStroke();
        circle(x, y, 15);
      }
    }
    
    pop();
  }
  
}
