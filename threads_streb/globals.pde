//POSTITIONING
PVector PULSECTR;
float ONETHIRD;
float TWOTHIRD;
float AREA;

int RESOLUTION;

//background 
float bgOpacity = 5;

void setupGlobals() {  
  //Set positioning constants
  PULSECTR = new PVector(0.0, 0.0);
  ONETHIRD = 0.33*width;
  TWOTHIRD = 0.66*width;
  AREA = width * height;
  
  RESOLUTION = floor(width/180); // scale resolution to canvas size 
  
}