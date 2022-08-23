void keyPressed() {
  if (key == ENTER) {
    saveFrame("frames/####.png");
    println("keyPressed(): saveFrame");
  }
  if (key == CODED) {
    if (keyCode == LEFT) {
      state.updateNowPageID(false);
      println("keyPressed(): updateNowPageID(false)");
    }
    if (keyCode == RIGHT) {
      state.updateNowPageID(true);
      println("keyPressed(): updateNowPageID(true)");
    }
  }
}


void mouseClicked() {
  state.updateNowPageID(true);
  println("mouseClicked(): updateNowPageID(true)");
}
