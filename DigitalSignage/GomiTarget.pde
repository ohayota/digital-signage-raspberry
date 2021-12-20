enum GomiTarget {
  Moyaseru("燃やせるごみ", 340, 30, 100),
  Moyasenai("燃やせないごみ", 130, 30, 80),
  Plastic("プラスチック容器包装", 30, 30, 100),
  CanBinPet("缶・びん・ペットボトル", 210, 30, 100),
  None("", 0, 0, 90);
  
  private final String name;
  private final int hue;
  private final int sat;
  private final int bri;
  private GomiTarget(String name, int hue, int sat, int bri) {
    this.name = name;
    this.hue = hue;
    this.sat = sat;
    this.bri = bri;
  }
  
  public String getName() {
    return name;
  }
  
  public int getHue() {
    return hue;
  }
  
  public int getSat() {
    return sat;
  }
  
  public int getBri() {
    return bri;
  }
}
