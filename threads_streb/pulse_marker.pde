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
  float sat = 90; // Start saturation lower than 100%

  // bpm
  int bpm;
  int prevBeatTime;
  int timeSinceBeat = 0;
  int timeBtwBeats;

  // fading booleans
  boolean fadeComplete = true;
  boolean drawMarker = true;
  boolean anim;
  boolean cent;
  
  
  PulseMarker(PVector iLoc) {
    initLocation = iLoc;
    
    if (centered) {
      location = PULSECTR.copy();
      pulseSzMultiplier = 2;
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
    //permClr = color(map(bpm, LOWBPM, HIGHBPM, 255, 100), opacity); // reverse mapping, slower is brighter
    permClr = color(255, opacity);
    clr = permClr;
  
  }
  
  void reduceMultiplier() {
    pulseSzMultiplier = 1;
  }
  
  void fadeColorDown() {
   if (clr >= 0) {
     fadeComplete = false;
     clr-=1;
    } else {
     fadeComplete = true;
     drawMarker = false;
    }
  }
  
  void fadeColorUp() {
    if (clr < permClr/3) {
      if (drawMarker == false) {
        drawMarker = true;
      }
      fadeComplete = false;
      clr += 1;
    } else {
     fadeComplete = true;
    }
  }
  
  boolean getFadeStatus() {
   return fadeComplete;
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
 
     if (dir == "shrinking") size = lerp(size, 1.0, lerpAmount);
     if (dir == "growing") size = lerp(size, initSize*pulseSzMultiplier, lerpAmount);

 
      
      //fill(clr);
      //noStroke();
      
      colorMode(HSB, 100);
      strokeWeight(0.5);
      stroke(100,sat,100, sat);
      noFill();
  
      pushMatrix();
      translate(width/2, height/2);
      
      
      if (!anim){
        if (cent) {
          location.lerp(PULSECTR, 0.01);
        } else {
          location.lerp(initLocation, 0.01);
        }
      }
      
      ellipse(location.x, location.y, size, size);
      popMatrix();
      
      colorMode(RGB, 255);
      
      // lower saturation until 0
      if (sat > 5) sat-=0.01;
    }

  }
}