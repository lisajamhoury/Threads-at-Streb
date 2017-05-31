boolean beat = false;
boolean growing = false;
boolean drawPulse = false; // allows for pulse array to grow but not be drawn on screen
ArrayList<PulseMarker> multiPulses;

int pulseCount = 0; // add pulse every two

// variables for expanding pulse boundaries over time
int pulseExDuration;  
int targetRadius;
int pulseExpandUnit;
int pulseStartTime;
int pulseIncTime;
int pulseBound = 2; //starting x boundaries 

// variables to time removal of pulses 
boolean removePulsesSet = false;
int pulsesToRemove = 0;
int removePulseTime = 0;
int removeTotalTime = 20000; // remove time in millis
int removeRate = 1000; // remove every 100 millis
float removeIncs = removeTotalTime/removeRate; // number of times to remove at given rate
float removeEachInc;

// set up for multipulse array 
void setupMultiPulse() { 
 
 //create array for pulse markers
 multiPulses = new ArrayList<PulseMarker>();
 
 // set radius and duration for pulse expansion
 pulseExDuration = 60000 * 3; //expand pulse over three minutes  
 targetRadius = width/2; // set the target width for each half 
 pulseExpandUnit = pulseExDuration/targetRadius; //how many millis between each x bound expansion
}

void drawMultiPulse(){
  
  //If pulse array is growing -- add on pulse
  if (growing == true) { 
    growing();
   } 
   
   //If pulse array is shrinking -- remove pulses in order they were drawn 
   if (growing == false) {
     shrinking();
   } 
 
   // Draw pulse if true, otherwise, just keep count   
   if (drawPulse == true) {
     runMultiPulse();
   }

}


void runMultiPulse() {
  
  if (multiPulses.size() == 0) {
    return;
  }
  
  boolean allPulsesFaded = true;
    
  for (int i = 0; i < multiPulses.size(); i++) {
   
    if (fadePulsesUp == true) {
   
     multiPulses.get(i).fadeColorUp();
     
     //check if each pulse has finished fading
     if (multiPulses.get(i).getFadeStatus() == false) {
       allPulsesFaded = false;
     }
   }
    
   if (fadePulsesDown == true) {
     multiPulses.get(i).fadeColorDown();
     
     //check if each pulse has finished fading 
     if (multiPulses.get(i).getFadeStatus() == false) {
       allPulsesFaded = false;
     }  
   }
   
   multiPulses.get(i).run();
  }
  
  if (fadePulsesUp == true && allPulsesFaded == true) {
    fadePulsesUp = false;
  }
  
  if (fadePulsesDown == true && allPulsesFaded == true) {
    fadePulsesDown = false;
  }
   
}


void growing() {
  if (pulseSensor == 1 && beat == false) {
    beat = true;
    pulseCount++;
 
    // every two heart beat creates a circle
    if (pulseCount == 2) {
      pulseCount = 0;
      PVector pulseLoc = getPulseLocation();
      // check to make sure you have a bpm
      if (currentBpm > 0) { 
        
          multiPulses.add(new PulseMarker(pulseLoc));
          
          // Change old pulse to grey
          int pulseAmt = multiPulses.size();
          if (pulseAmt > 1) {
            PulseMarker temp = multiPulses.get(pulseAmt-2);
            temp.setColor();
            temp.reduceMultiplier();  
          } 
       }
    }
  }
 
 if ( pulseSensor == 0 && beat == true ) {
   beat = false;
  }
}

void shrinking() {
   if (removePulsesSet == false) {
     pulsesToRemove = multiPulses.size();  
     removePulseTime = millis();
     removeEachInc = pulsesToRemove / removeIncs;
     removePulsesSet = true;
   }
      
   if (millis() > removePulseTime + removeRate) {
     if (multiPulses.size() > removeEachInc) { 
       for (int i = 0; i < removeEachInc; i++) {
         int pos = multiPulses.size() - 1;
         multiPulses.remove(pos);
       }
     } else if (multiPulses.size() > 0) {
      int pos = multiPulses.size() - 1;
      multiPulses.remove(pos);
    }  
   removePulseTime = millis();
 }
}

void expandPulseBounds() {
 int pulseTimeElapsed = millis() - pulseIncTime;
 
 if (pulseTimeElapsed > pulseExpandUnit) {
   if (pulseBound <= targetRadius) { // stop incrementing when radius hit
     pulseBound++;
   }
       
   pulseIncTime = millis();
 }
}

void noBoundExpansion() {
 pulseBound = 5;
}


PVector getPulseLocation() {
 PVector newPulseLoc;
 newPulseLoc = circlePulse(pulseBound);
 return newPulseLoc;
}


PVector circlePulse(float radius) {
  PVector newLoc;
  
  float rad = radius;
  float angle = random(0, TWO_PI);
  float newX = PULSECTR.x + (cos(angle) * rad);
  float newY = PULSECTR.y + (sin(angle) * rad);
  newLoc = new PVector(newX, newY);

  return newLoc;
}