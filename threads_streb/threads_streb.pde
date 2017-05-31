// SET YOUR PERFORMER IN process_data line 24 
// SET ROPE CENTER with 'p', the enter PULSECTR in globals line 14

PImage alphaImg;

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
  
  //load alpha img
  alphaImg = loadImage("alpha.png");
  
  // for processing bpm
  setupProcessData();
  
  // functions to manage pulse array
  setupMultiPulse();
}

void draw() {
  noStroke();
  //background(255);
  fill(0,bgOpacity);
  rect(0,0,width,height);
  
  
  if (debug) {
    //get fake data from csv
    getCsvData();
  } 
  
  //if (multiPulses.size() > 0) {
  //  println(multiPulses.get(0).size);
  //}
  
  getSensorData();
  runControls();
  
  if (setup) setRopeCenter(); 
  
  //image(alphaImg, 0,0,width,height);
}