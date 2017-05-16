//variables for manipulating data
int pulseSensor = 0;

//Constants for mapping data 
int LOWBPM = 30; // reset for perfomer!!
int HIGHBPM = 120; // reset for perfomer!!

//Pulse bpm timing
int pulseTimeCtr; // count time elapsed since last calculation
int pulseCtr = 0; // count number of pulses
int BPMTIMESPAN = 5000; // take bpm every 5 seconds 
int ONEMINUTE = 60000;
int lastPulseSensorVal;
int currentBpm;

//pulse variables
boolean pulse = false;

void setupProcessData() {
  pulseTimeCtr = msPassed;
}

void getSensorData() { 
 pulseSensor = heartBeatLisa; // RESET FOR PERFORMER 
 calculateBpm();
}


void calculateBpm() {
 int timeElapsed = msPassed - pulseTimeCtr; 

 if (pulseSensor == 1 && lastPulseSensorVal == 0) {
   pulseCtr++;
 }
  
 if (timeElapsed > BPMTIMESPAN) {
  currentBpm = (ONEMINUTE/BPMTIMESPAN)*pulseCtr; 
  currentBpm = limitBpm(currentBpm, LOWBPM, HIGHBPM);
  pulseTimeCtr = msPassed;
  pulseCtr = 0;
 }
 lastPulseSensorVal = pulseSensor;
}

// Keep bpm within range so all are drawn
int limitBpm(int bpm, int lowerBound, int upperBound) {
  if (bpm < lowerBound) {
    bpm = lowerBound;
  }
  
  if (bpm > upperBound) {
    bpm = upperBound;
  }
  
  return bpm;  
}