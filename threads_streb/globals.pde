//POSTITIONING
PVector PULSECTR;
float ONETHIRD;
float TWOTHIRD;
float AREA;

int RESOLUTION;

//background 
float bgOpacity = 20;

void setupGlobals() {  
  //Set positioning constants
  PULSECTR = new PVector(width/2, height/2); // SET ROPE CENTER HERE
  ONETHIRD = 0.33*width;
  TWOTHIRD = 0.66*width;
  AREA = width * height;
  
  RESOLUTION = floor(width/180); // scale resolution to canvas size 
  
}