// pulse states
boolean pulse1 = false;
boolean pulse2 = false;
boolean pulse3 = false; 

// used to show and hide all pulses
boolean fadePulsesUp = false;
boolean fadePulsesDown = false;

// keep track of time for pulses
boolean pulseTimerStarted = false;

// globals for starting new markers in proper state 
boolean centered = false;
boolean animate = false;

// pulse marker circumference lerp amount
float lerpAmount = 0.01;
float lerpInc = 0.01;


void keyPressed() {
  char inKeyChar = key;
  processControls(inKeyChar);
}

void processControls(char inKeyChar) {
  
  // show hide pulse -- growing
  if (inKeyChar == '1') {
    pulse1 = true;
    pulse2 = false;
    pulse3 = false;
  }
  
  // Center all markers 
  if (inKeyChar == '2') {
    if (!centered) {
     for (PulseMarker marker : multiPulses) {
       marker.centerMarker();
     }
     centered = true;
   }
  }
  
  // Uncenter all markers 
  if (inKeyChar == '3') {
   if (centered) {
    for (PulseMarker marker : multiPulses) {
       marker.unCenterMarker();
     }
     centered = false;
   }
  }
  
  // Toggle pulse marker animation 
  if (key == '4') { 
    
    for (PulseMarker marker : multiPulses) {
       marker.toggleAnimate();
     }
   
    animate = !animate;
    
    // chanage the background opacity based on animation state
    if (animate) {
      bgOpacity = 1;
    } else {
      bgOpacity = 10;
    }
  }
  
  // Increase pulse lerp speed 
  if (inKeyChar == 'w') {
   lerpAmount += lerpInc;
  }
  
  // Decrease pulse lerp speed 
  if (inKeyChar == 'q') {
   lerpAmount -= lerpInc;
  }

  // stop from growing / toggle growing/shrinking pulse
  if (inKeyChar == '9') {
    pulse1 = false;
    pulse2 = false;
    pulse3 = true;  
  } 
}


void runControls() {

  // start pulses, draw pulses
  if (pulse1 == true) {
    if (fadePulsesDown == true) {
      fadePulsesUp = true;
      fadePulsesDown = false;
    }
    
    drawPulse = true;
    
    // if there's a bpm and it's not growing, 
    // start the bpm timer, start growing and start expanding bounds on screen, and drawpulse  
    if (currentBpm > 10 || pulseTimerStarted == true) {
      if (!growing) {
        //begin timer
        pulseTimerStarted = true;
        println("timer started");
        pulseStartTime = msPassed; // replace millis with fake millis
        pulseIncTime = pulseStartTime;
      }
      growing = true;

      expandPulseBounds();

      drawMultiPulse();
    } else {
      // debugging 
      //println("nope", currentBpm);
    }
  }

  // hide pulses
  if (pulse2 == true) {
    fadePulsesDown = true;
    growing = true;
    expandPulseBounds();
    drawMultiPulse();
  }

  // remove pulses 
  if (pulse3 == true) {
    if (fadePulsesDown == true) {
      fadePulsesUp = true;
      fadePulsesDown = false;
    }
    
    growing = false;
    drawPulse = true;
  
    expandPulseBounds();
    drawMultiPulse();
    
  }
  
} // Close run controls