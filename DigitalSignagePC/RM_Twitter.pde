class TwitterRModule extends RModuleClass {
  
  final String CONSUMER_KEY;
  final String CONSUMER_KEY_SECRET;
  final String ACCESS_TOKEN;
  final String ACCESS_TOKEN_SECRET;
  final long TWEET_ID;
  
  private Status tweetStatus;
  private PImage twitterUserIcon;
  private String twitterUserName = "";
  private String twitterUserScreenName = "";
  private String tweetText = "";
  private PImage[] tweetImages;
  
  final PGraphics background;
  
  public TwitterRModule(processing.data.JSONObject json) {
    super(RModule.Twitter);
    json = json.getJSONObject(rModule.getName());
    this.CONSUMER_KEY = json.getString("CONSUMER_KEY");
    this.CONSUMER_KEY_SECRET = json.getString("CONSUMER_KEY_SECRET");
    this.ACCESS_TOKEN = json.getString("ACCESS_TOKEN");
    this.ACCESS_TOKEN_SECRET = json.getString("ACCESS_TOKEN_SECRET");
    this.TWEET_ID = json.getLong("TWEET_ID");
    this.background = generateBackground();
    this.update();
  }
  
  private PGraphics generateBackground() {
    PImage twitterLogo = loadImage(rModule.getPath() + "2021 Twitter logo - blue.png");
    final float logoRatio = twitterLogo.height / float(twitterLogo.width); // 縦横比
    final float logoWidth = 80.0;
    final float logoHeight = logoWidth * logoRatio;
    PGraphics pg = createGraphics(w, h);
    pg.beginDraw();
    pg.colorMode(HSB, 360, 100, 100, 100);
    pg.background(0, 0, 100);
    pg.image(twitterLogo, w-logoWidth-50, 50, logoWidth, logoHeight);
    pg.endDraw();
    pg.mask( sizeToModuleMask( rModule.getSize() ) );
    return pg;
  }
  
  public void update() {
    tweetImages = new PImage[3];
  
    // API関連の設定
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setDebugEnabled(true)
      .setOAuthConsumerKey(CONSUMER_KEY)
      .setOAuthConsumerSecret(CONSUMER_KEY_SECRET)
      .setOAuthAccessToken(ACCESS_TOKEN)
      .setOAuthAccessTokenSecret(ACCESS_TOKEN_SECRET);
      
    // TwitterAPIインスタンス取得
    Twitter twitter = new TwitterFactory(cb.build()).getInstance();
    
    try {
      // 指定IDをもつツイートを取得する
      try {
        tweetStatus = twitter.showStatus(TWEET_ID);
        twitterUserName = tweetStatus.getUser().getName();
        twitterUserScreenName = "@" + tweetStatus.getUser().getScreenName();
        tweetText = tweetStatus.getText();
      } catch (Exception e) {
        println("updateTwitter(): 該当のツイート(id:" + TWEET_ID + ")を取得できませんでした。" + e);
        super.isUpdated = false;
        return;
      }
      
      // 指定ツイートに含まれる画像を取得する（3枚まで）
      MediaEntity[] tweetMedias = tweetStatus.getMediaEntities();
      for (int i = 0; i < tweetImages.length; i++) {
        try {
          tweetImages[i] = pImageToSquare(loadImage(tweetMedias[i].getMediaURLHttps()), CENTER);
        } catch (Exception e) {
          tweetImages[i] = dummy360x360;
          println("updateTwitter(): ツイートに含まれる画像が3枚未満です。" + e);
        }
      }
      
      // ツイートからアカウント画像を取得する
      twitterUserIcon = loadImage(tweetStatus.getUser().get400x400ProfileImageURL());
      PGraphics maskLayer = createGraphics(twitterUserIcon.width, twitterUserIcon.width);
      maskLayer.beginDraw();
      maskLayer.noStroke();
      maskLayer.fill(255);
      maskLayer.circle(maskLayer.width/2, maskLayer.height/2, maskLayer.width);
      maskLayer.endDraw();
      // 画像を丸く切り抜く
      twitterUserIcon.mask(maskLayer);
      
      println("updateTwitter(): ツイートを取得しました。");
      super.isUpdated = true;
    } catch (Exception e) {
      println("updateTwitter(): ツイートを取得できませんでした。" + e);
      super.isUpdated = false;
    }
  }
  
  public void draw(Area area) {
    super.draw(area);
    
    push();
    
    // 背景表示
    image(this.background, x, y, w, h);
    
    if (super.isUpdated) {
      // Twitterアカウントのアイコン表示
      image(twitterUserIcon, x+50, y+50, 80, 80);
      
      // Twitterアカウントの表示名、アカウント名（@hogehoge）を表示
      drawText(LEFT, BASELINE, state.BLACK_COLOR, 32, twitterUserName, x+150, y+50);
      drawText(LEFT, BASELINE, state.GRAY_COLOR, 24, twitterUserScreenName, x+150, y+90);
      
      // ツイートのテキストを表示
      drawText(LEFT, BASELINE, state.BLACK_COLOR, 20, tweetText, x+50, y+150, w-100, h-50-((w-100)*2/3)-200);
      
      // ツイートから取得した画像を3枚表示
      image(tweetImages[0], x+50, y+h-50-((w-100)*2/3), (w-100)*2/3, (w-100)*2/3);
      image(tweetImages[1], x+50+(w-100)*2/3, y+h-50-((w-100)*2/3), (w-100)/3, (w-100)/3);
      image(tweetImages[2], x+50+(w-100)*2/3, y+h-50-((w-100)/3), (w-100)/3, (w-100)/3);
      strokeWeight(1);
      stroke(state.WHITE_COLOR);
      noFill();
      // 画像どうしの境界をわかりやすくするために白い枠をつける
      rect(x+50, y+h-50-((w-100)*2/3), (w-100)*2/3, (w-100)*2/3);
      rect(x+50+(w-100)*2/3, y+h-50-((w-100)*2/3), (w-100)/3, (w-100)/3);
      rect(x+50+(w-100)*2/3, y+h-50-((w-100)/3), (w-100)/3, (w-100)/3);
    } else {
      fill(0, 0, 0, 50);
      noStroke();
      rect(x, y, w, h, state.MODULE_RECT_ROUND);
      
      drawText(CENTER, CENTER, state.WHITE_COLOR, 24, "ツイートを取得できませんでした", x+w/2, y+h/2);
    }
    
    pop();
  }
  
}
