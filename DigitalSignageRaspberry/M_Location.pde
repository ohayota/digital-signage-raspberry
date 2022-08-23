class LocationModule {
  
  final String location;
  
  public LocationModule(processing.data.JSONObject json) {
    this.location = json.getString("LOCATION");
  }
  
  public void draw() {
    push();
    
    blendMode(EXCLUSION);
    drawText(RIGHT, BASELINE, state.WHITE_COLOR, 36, location, width-100, 30);
    
    pop();
  }
  
}
