class PulseMarker {
  
  // location 
  PVector initLocation;
  PVector location;
  PVector acceleration;
  PVector velocity;
  float velocityY;
  
  // size
  float pulseSmall = 0.2 * width;
  float pulseLarge = 0.6 * width;
  float initSize;
  float size;
  float pulseSzMultiplier = 1;
  String dir = "shrinking"; 
  
  // color
  float opacity = 30;
  color clr;
  color permClr;
  color startClr = color(255,0,0, 100);
  float brightness; 
  boolean soloMkr;
  float stkWt = 5;
  //float sat = 10; // Start saturation lower than 100%

  // bpm
  int bpm;
  int prevBeatTime;
  int timeSinceBeat = 0;
  int timeBtwBeats;

  // fading booleans
  boolean fadeComplete = true;
  boolean drawMarker;
  boolean anim;
  boolean cent;
  boolean toStrobe;
  
  PulseMarker(PVector iLoc) {
    initLocation = iLoc;
    
    if (drawPulse) {
      drawMarker = true;
    } else {
      drawMarker = false;
    }
    
    if (centered) {
      location = PULSECTR.copy();
      pulseSzMultiplier = 10;
      cent = true;
    } else {
      location = initLocation.copy();
      cent = false;
    }
    
    if (animate) {
      anim = true;
    } else {
      anim = false;
    }
    
    if (solo) {
      brightness = 100;
      soloMkr = true;
    } else {
      brightness = 30;
      soloMkr = false;
    }
    
    if (strobe) {
      toStrobe = true;
    } else {
      toStrobe = false;
    }
    
    bpm = currentBpm;
    timeBtwBeats = ONEMINUTE/bpm;
    prevBeatTime = millis();
    initSize = map(currentBpm, LOWBPM, HIGHBPM, pulseSmall, pulseLarge); // reverse mapping, slower is larger
    size = initSize;
    acceleration = new PVector(0,0);
    velocityY = map(currentBpm, LOWBPM, HIGHBPM, 0.1, .5); // slower is slower 
    velocity = new PVector(0, velocityY);
    clr = startClr;
    if (drawPulse == false) {
      clr = 0;
    }
  }
  
  void centerMarker() {
    cent = true;
  }
  
  void unCenterMarker() {
    cent = false;
  }
  
  void setColor() {
    permClr = color(255, opacity);
    clr = permClr;
  }
  
  void reduceMultiplier() {
    pulseSzMultiplier = 1;
  }
  
  void fadeColorDown() {
   if (brightness >= lowBright) {
     fadeComplete = false;
     brightness-=1;
    } else {
      
     fadeComplete = true;
    }
  }
  
  void fadeColorUp() {
    if (brightness < highBright) {
      fadeComplete = false;
      brightness += 1;
    } else {
     fadeComplete = true;
    }
  }
  
  boolean getFadeStatus() {
   return fadeComplete;
  }
  
  void toStrobe() {  
    toStrobe = true;
  }
  
  void toggleAnimate() {
    anim = !anim;
  }
  
  void animate() {
    location.add(velocity);
  }

  void run() {
    if (drawMarker == true) {
      if (anim == true) animate();
   
      timeSinceBeat = millis() - prevBeatTime;
      
      if (timeSinceBeat > timeBtwBeats) {
        dir = "shrinking";
        prevBeatTime = millis();
      } else if (timeSinceBeat > timeBtwBeats/2) { 
        dir = "growing";
      }
      
     if (toStrobe) {
       if (pulseSzMultiplier < 50) {
         pulseSzMultiplier+=0.05;
         stkWt+=0.1;
       }
     } 
     
     if (dir == "shrinking") size = lerp(size, 1.0, lerpAmount);
     if (dir == "growing") size = lerp(size, initSize*pulseSzMultiplier, lerpAmount);
     
    colorMode(HSB, 100);
    strokeWeight(stkWt);
    stroke(0, 0, brightness); // 30 when grayed out
    noFill();
    
    if (!anim){
      if (cent) {
        location.lerp(PULSECTR, 0.01);
      } else {
        location.lerp(initLocation, 0.01);
      }
    }
    
    ellipse(location.x, location.y, size, size);
    
    colorMode(RGB, 255);
      
    }

  }
}