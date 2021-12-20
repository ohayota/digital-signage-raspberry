void keyPressed() {
  if (key == 'o' || key == 'O') {
    openCloseRModule.isOpen = true;
    println("keyPressed(): isOpen = true");
  }
  if (key == 'c' || key == 'C') {
    openCloseRModule.isOpen = false;
    println("keyPressed(): isOpen = false");
  }
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
