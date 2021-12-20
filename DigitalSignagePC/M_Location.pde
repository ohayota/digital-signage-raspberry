class LocationModule {
  
  private final String location;
  
  public LocationModule(String location) {
    this.location = location;
  }
  
  public void draw() {
    push();
    
    blendMode(EXCLUSION);
    drawText(RIGHT, BASELINE, state.WHITE_COLOR, 36, location, width-100, 30);
    
    pop();
  }
  
}
