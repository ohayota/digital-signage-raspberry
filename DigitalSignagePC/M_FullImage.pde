public class FullImageModule {
  
  private final PImage image;
  
  public FullImageModule(PImage image) {
    this.image = image;
  }
  
  public void draw() {
    push();
    
    image(image, 0, 0, width, height);
    
    pop();
  }
  
}
