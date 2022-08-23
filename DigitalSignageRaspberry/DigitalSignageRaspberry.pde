final boolean TEST_MODE = false;


import processing.io.*;
import java.net.*;
import java.io.*;
import twitter4j.*;
import twitter4j.api.*;
import twitter4j.auth.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.management.*;
import twitter4j.util.*;
import twitter4j.util.function.*;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;


State state;

// ローカルで読み込んだ素材
PImage dummy1080x1920;
PImage dummy1920x1080;
PImage dummy360x360;

GridModule grid;
Placeholder placeholder;
DateModule dateModule;
LocationModule locationModule;
PageControlModule pageControlModule;
ProgressBarModule progressBarModule;

LaunchingScreen launchingScreen;
ArrayList<Page> pages;


void settings() {
  //size(1920, 1080);
  fullScreen();
}


void setup() {
  frameRate(1);
  noCursor();
  colorMode(HSB, 360, 100, 100, 100);
  
  pages = new ArrayList<Page>();
  
  final processing.data.JSONObject stateSettingJSON = loadJSONObject("setting.json").getJSONObject("State");
  state = new State(stateSettingJSON);
  
  // OSによりインストールしたフォントの名称が微妙に異なるため、必要な方のみ使う
  textFont(createFont("NotoSansCJKjp-Bold", 32)); // Mac
  //textFont(createFont("Noto Sans CJK jp Bold", 32)); // RasPi
  
  launchingScreen = new LaunchingScreen();
  if (TEST_MODE) {
    //test();
    exit();
  }
  
  thread("initialize");
} //<>//
 //<>//

void draw() {
  if (state.getNowPageID() == -1) { //<>//
    launchingScreen.draw(); //<>//
  } else {
    updateDatas();
    pages.get(state.getNowPageID()).draw();
  }
}

void updateDatas() {
  dateModule.updateDate();
  
  for (Page page: pages) {
    for (OpenCloseRModule openClose: page.openCloseRModules) {
      openClose.update();
    }
    for (TemperatureRModule temperature: page.temperatureRModules) {
      temperature.update();
    }
    for (BrightnessRModule brightness: page.brightnessRModules) {
      brightness.update();
    }
  }
  
  final boolean isUpdatedSecond = (dateModule.second != dateModule.beforeSecond);
  final boolean isUpdatedMinute = (dateModule.minute != dateModule.beforeMinute);
  final boolean isUpdatedDay = (dateModule.day != dateModule.beforeDay);
  
  // 日付が更新されたら実行する
  if (isUpdatedDay) {
    println("日付が変わりました。");
    dateModule.updateYoubi();
    
    for (Page page: pages) {
      for (BusRModule bus: page.busRModules) {
        bus.update();
      }
      for (GomiRModule gomi: page.gomiRModules) {
        gomi.update();
      }
    }
    
    dateModule.updateBeforeDay();
  }
  
  // 1秒間隔で実行する
  if (isUpdatedSecond) {
    if (dateModule.second % state.STAY_SECOND == 0) {
      state.updateNowPageID(true);
    }
    if (isUpdatedMinute) {
      for (Page page: pages) {
        for (BusRModule bus: page.busRModules) {
          bus.refleshTop2();
        }
      }
      dateModule.updateBeforeMinute();
    }
    if (dateModule.minute + dateModule.second == 0) {
      println(dateModule.hour + "時になりました。");
      for (Page page: pages) {
        for (WeatherRModule weather: page.weatherRModules) {
          weather.update();
        }
        for (TwitterRModule twitter: page.twitterRModules) {
          twitter.update();
        }
      }
    }
    
    dateModule.updateBeforeSecond();
  }
}


PImage pImageToSquare(PImage image, int mode) {
  int w = image.width;
  int h = image.height;
  if (w == h) return image;
  
  boolean isLongerHeight = (w < h);
  if (isLongerHeight) { // 画像が縦長のときの切り取り方
    if (mode == TOP) image = image.get(0, 0, w, w);
    if (mode == CENTER) image = image.get(0, h/2-w/2, w, w);
    if (mode == BOTTOM) image = image.get(0, h-w, w, w);
  } else { // 画像が横長のときの切り取り方
    if (mode == LEFT) image = image.get(0, 0, h, h);
    if (mode == CENTER) image = image.get(w/2-h/2, 0, h, h);
    if (mode == RIGHT) image = image.get(w-h, 0, h, h);
  }
  return image;
}


PImage pImageCut(PImage image, int modeX, int modeY, int afterWidth, int afterHeight) {
  int w = image.width;
  int h = image.height;
  
  if (modeX == LEFT) image = image.get(0, 0, afterWidth, h);
  if (modeX == CENTER) image = image.get(w/2-afterWidth/2, 0, afterWidth, h);
  if (modeX == RIGHT) image = image.get(w-afterWidth, 0, afterWidth, h);
  
  if (modeY == TOP) image = image.get(0, 0, afterWidth, afterHeight);
  if (modeY == CENTER) image = image.get(0, h/2-afterHeight/2, afterWidth, afterHeight);
  if (modeY == BOTTOM) image = image.get(0, h-afterHeight, afterWidth, afterHeight);
  
  return image;
}

void drawText(int alignX, int alignY, color c, int size, String text, int x, int y) {
  pushStyle();
  textAlign(alignX, alignY);
  textSize(size);
  fill(c);
  if (alignY == BASELINE) {
    text(text, x, y+size);
  } else {
    text(text, x, y);
  }
  popStyle();
}

void drawText(int alignX, int alignY, color c, int size, String text, int x, int y, int w, int h) {
  pushStyle();
  textAlign(alignX, alignY);
  textSize(size);
  fill(c);
  if (alignY == BASELINE) {
    text(text, x, y+size, w, h);
  } else {
    text(text, x, y, w, h);
  }
  popStyle();
}
