class PulseRect {

  // bpm
  int bpm;
  int prevBeatTime;
  int timeSinceBeat = 0;
  int timeBtwBeats;
  
  float brightness;

  String dir;

  PulseRect() {
    bpm = currentBpm;
    timeBtwBeats = ONEMINUTE/bpm;
    prevBeatTime = millis();
  }

  void updateRect() {
    bpm = currentBpm;
    timeBtwBeats = ONEMINUTE/bpm;

    timeSinceBeat = millis() - prevBeatTime;

    if (timeSinceBeat > timeBtwBeats) {
      dir = "shrinking";
      prevBeatTime = millis();
    } else if (timeSinceBeat > timeBtwBeats/2) { 
      dir = "growing";
    }
    
    if (dir == "shrinking") brightness = lerp(brightness, 0.0, 0.8);
    if (dir == "growing") brightness = lerp(brightness, 100.0, 0.8);
    //println(dir, brightness);
    
  } 

  void drawRect() {
    
    colorMode(HSB, 100);
    noStroke();
    
    fill(0,0,brightness);
    rect(-1, -1, width+2, height+2);


  }
} 