// SET YOUR PERFORMER IN process_data line 24 

// used for csv data 
boolean debug = true;

void setup() {
  size(1400, 1050, P3D); // streb resolution
 
  background(0);
  smooth(4);
  noCursor();
 
  // set positioning constants
  setupGlobals();
  
  if (debug){
    
    // setup fake data
    csvSetup();
    
  } else {
    
    //setup osc
    oscSetup(5502);
  }
  
  // for processing bpm
  setupProcessData();
  
  // functions to manage pulse array
  setupMultiPulse();
}

void draw() {
  noStroke();
  fill(0,bgOpacity);
  rect(0,0,width,height);
  
  
  if (debug) {
    //get fake data from csv
    getCsvData();
  } 
  
  getSensorData();
  runControls();

}