public class LaunchingScreen {
  
  FullImageModule background;
  
  // 起動画面用の初期化済フラグ
  private boolean isInitializedImages;
  private boolean isInitializedDates;
  private boolean isInitializedWeather;
  private boolean isInitializedBus;
  private boolean isInitializedGomi;
  private boolean isInitializedTwitter;
  
  public LaunchingScreen() {
    isInitializedImages = false;
    isInitializedDates = false;
    isInitializedWeather = false;
    isInitializedBus = false;
    isInitializedGomi = false;
    isInitializedTwitter = false;
    
    background = new FullImageModule(pImageCut(loadImage("background.jpg"), CENTER, CENTER, width, height));
  }
  
  public void setIsInitializedImages(boolean bool) {
    isInitializedImages = bool;
  }
  public void setIsInitializedDates(boolean bool) {
    isInitializedDates = bool;
  }
  public void setIsInitializedWeather(boolean bool) {
    isInitializedWeather = bool;
  }
  public void setIsInitializedBus(boolean bool) {
    isInitializedBus = bool;
  }
  public void setIsInitializedGomi(boolean bool) {
    isInitializedGomi = bool;
  }
  public void setIsInitializedTwitter(boolean bool) {
    isInitializedTwitter = bool;
  }
  
  public void draw() {
    background.draw();
    
    push();
    
    drawText(CENTER, BASELINE, state.GREEN_COLOR, 148, "DIGITAL SIGNAGE", width/2, height/2-380);
    //drawText(CENTER, BASELINE, BLACK_COLOR, 48, LOCATION, width/2, height/2-180);
    stroke(state.BLACK_COLOR);
    strokeWeight(5);
    noFill();
    line(300, height/2-200, width-300, height/2-200);
    
    if (isInitializedDates) {
      drawText(CENTER, BASELINE, state.GREEN_COLOR, 36, "カレンダー取得", width/2, height/2+40);
    } else {
      drawText(CENTER, BASELINE, state.BLACK_COLOR, 36, "カレンダー取得", width/2, height/2+40);
    }
    
    if (isInitializedImages) {
      drawText(CENTER, BASELINE, state.GREEN_COLOR, 36, "画像取得", width/2, height/2+100);
    } else {
      drawText(CENTER, BASELINE, state.BLACK_COLOR, 36, "画像取得", width/2, height/2+100);
    }
    
    if (isInitializedBus) {
      drawText(CENTER, BASELINE, state.GREEN_COLOR, 36, "バス情報取得", width/2, height/2+160);
    } else {
      drawText(CENTER, BASELINE, state.BLACK_COLOR, 36, "バス情報取得", width/2, height/2+160);
    }
    
    if (isInitializedGomi) {
      drawText(CENTER, BASELINE, state.GREEN_COLOR, 36, "ごみカレンダー取得", width/2, height/2+220);
    } else {
      drawText(CENTER, BASELINE, state.BLACK_COLOR, 36, "ごみカレンダー取得", width/2, height/2+220);
    }
    
    if (isInitializedWeather) {
      drawText(CENTER, BASELINE, state.GREEN_COLOR, 36, "天気情報取得", width/2, height/2+280);
    } else {
      drawText(CENTER, BASELINE, state.BLACK_COLOR, 36, "天気情報取得", width/2, height/2+280);
    }
    
    if (isInitializedTwitter) {
      drawText(CENTER, BASELINE, state.GREEN_COLOR, 36, "ツイート取得", width/2, height/2+340);
    } else {
      drawText(CENTER, BASELINE, state.BLACK_COLOR, 36, "ツイート取得", width/2, height/2+340);
    }
    
    pop();
  }
  
}
