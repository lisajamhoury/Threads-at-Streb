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
boolean solo = true;

// pulse marker circumference lerp amount
float lerpAmount = 0.03;
float lerpInc = 0.01;
float fastLerp = 0.03;
float slowLerp = 0.01;

float highBright = 100;
float lowBright = 30;

boolean strobe = false;

boolean setup = false;

int strobeStartTime = 0;

PulseRect pulseRect;
boolean drawRect = false;

void keyPressed() {
  char inKeyChar = key;
  processControls(inKeyChar);
}

void processControls(char inKeyChar) {
  
  // find rope center for setup
  if (inKeyChar == 'p') {
    setup = !setup;
  }
  
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
  
  // Toggle solo 
  if (inKeyChar == '4') {
    
    // toggle solo
    solo = !solo;
    
    // change brightness and lerp speed based on solo
    if (solo) {
      fadePulsesUp = true;
      lerpAmount = fastLerp;   
    } else {
      fadePulsesDown = true;
      lerpAmount = slowLerp;
    }    
  }
  
  // Grow circles to full rect Strobe 
  if (inKeyChar == '5') {
    strobe = !strobe;
    
    pulseRect = new PulseRect();
    
    strobeStartTime = millis();
   
    // increase multiplier
    for (PulseMarker marker : multiPulses) {
      marker.toStrobe();
    }

    pulse1 = false;
    pulse2 = true;
    pulse3 = false;
  }
  
  // BLACK OUT 
  if (inKeyChar == '0') {
    pulse1 = false;
    pulse2 = false;
    pulse3 = true;
  }
  
  // Increase pulse lerp speed 
  if (inKeyChar == 'w') {
   lerpAmount += lerpInc;
  }
  
  // Decrease pulse lerp speed 
  if (inKeyChar == 'q') {
   lerpAmount -= lerpInc;
  }


}


void runControls() {

  // start pulses, draw pulses
  if (pulse1 == true) {
    //if (fadePulsesDown == true) {
    //  fadePulsesUp = true;
    //  fadePulsesDown = false;
    //}
    
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
    //fadePulsesDown = true;
    
    growing = true;
    expandPulseBounds();
    drawMultiPulse();
    
    if (strobeStartTime + 3000  < millis() && drawRect == false) {
      
      drawPulse = false;
      
      for (PulseMarker marker : multiPulses) {
       marker.drawMarker = false;
      }
      
      drawRect = true;
    }
    
    if (drawRect) {
      pulseRect.updateRect();
      pulseRect.drawRect();
    }
  }

  // Blackout  
  if (pulse3 == true) {
    
    drawPulse = false; 
    
    fill(0);
    rect(-1,-1,width+2,height+2);
   
  }
  
} // Close run controls