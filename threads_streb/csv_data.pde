Table table;

int rowCount;
int rowIndex;
int startRow = 16501;
int endRow = 20281;
int msPerS = 1000;
float fps = 60;
float msPerFrame = msPerS/fps;
int msPassed = 0;
float dataRate = 86;
int currentDataFrame = 0;

//variables for receiving data
int polar0;

void csvSetup() {
  table = loadTable("data/osc_dancers20161121_third.csv", "header");  
  rowCount = table.getRowCount();
  
  rowIndex = startRow;
}

void getCsvData() {

  msPassed = round(msPerFrame * frameCount);
  int newDataFrame = round(msPassed/dataRate);
  
  if (newDataFrame > currentDataFrame) {
    currentDataFrame = newDataFrame;
    rowIndex++;
    
    if (rowIndex > endRow) {
      rowIndex = startRow;
    }
      
    TableRow row = table.getRow(rowIndex);
  
    heartBeatLisa = row.getInt("pulse");

  }
}