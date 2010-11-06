/**
 * PeggyDraw
 * v 2.0
 * by Windell H Oskay, Evil Mad Scientist Laboratories
 *  
 */
  
  /* 
  Could really use some cleanup -- need to define a class for our GUI text buttons.
  
  A bug on reading back(?) the durations is still there.
  
  */
  
  
int PeggyData[];
int PeggyDurations[];

int brightFillColor = 15;
int StrokeColor = 2;
int TextColor = 10;
int TextHighLight = 15;

int dimFillColor = 3;
int bgColor = 1;
int FrameCount = 1;    // NUMBER of existing frames.
int CurrentFrame = 1;
int CurrentDuration = 100;

//int SampX,SampY,SampZ;
int DataX,DataY;
 
color   circleColor = color(255, 128, 0, 128);

boolean SteadyRate = true;

boolean overRect(int x, int y, int width, int height) 
{
  if (mouseX >= x && mouseX <= x+width &&  mouseY >= y && mouseY <= y+height) 
    return true; 
  else 
    return false;
}
 
 
void StoreFrame()
{
int j = 0;
int offset = 625*(CurrentFrame - 1);

  while (j < 625){
    PeggyData[offset + j] = GrayArray[j];
    j++; 
  }
  

}


void RecallFrame(int theFrame)
{
int j = 0;
int offset = 625*(theFrame - 1);

  while (j < 625){
     GrayArray[j] = PeggyData[offset + j];
    j++; 
  }
  
   CurrentDuration = PeggyDurations[theFrame - 1];
}


void InsertFrame()
{  // Insert one frame AFTER current frame, filled with zeroes.
int j = 0; 
int offset = 625*(CurrentFrame);

  while (j < 625){
     PeggyData = splice(PeggyData, 0, offset); 
    j++; 
  }
  
  PeggyDurations = splice(PeggyDurations, CurrentDuration, CurrentFrame); 
}



void DeleteFrame()
{  // Remove the current frame from the PeggyData[] array.
 
int[] firstpart = subset(PeggyData, 0, 625*(CurrentFrame - 1)); // subset(array, offset, length)
int[] endpart = subset(PeggyData, 625*(CurrentFrame)); // subset(array, offset)  -> to end!
PeggyData = concat(firstpart, endpart);	  

int[] FirstDur = subset(PeggyDurations, 0, CurrentFrame); // subset(array, offset, length)
int[] EndDur = subset(PeggyDurations, CurrentFrame+1); // subset(array, offset)  -> to end!
PeggyDurations = concat(FirstDur, EndDur);	  

}




void mousePressed() {

  int mxin, myin;
  int x,y;

  if ((mouseX > 0) && (mouseX < cols*cellSize) && (mouseY > 0) && (mouseY < rows*cellSize))
  {  // i.e., if we clicked within the LED grid
    mxin =    floor( mouseX / cellSize);
    myin =    floor( mouseY / cellSize);

//    SampX = mxin;
//    SampY = myin;
//    SampZ = GrayArray[mxin*cols + myin];

    if ((GrayArray[mxin*cols + myin]) == brightFillColor)  // if the dot is already in our color
        //   if (true)  // if the dot is already in our color
      pencolor = dimFillColor;                // We're erasing
    else
      pencolor = brightFillColor;     // We're drawing  

    pendown = true;
  }
  
  else
  {  // Check GUI buttons!

    if( clearButton.isSelected() ) {
      j = 0;
      while (j < 625){
        GrayArray[j] = 0;
        j++; 
      }
    }
    else if( fillButton.isSelected() ) {
      j = 0;
      while (j < 625){
        GrayArray[j] = brightFillColor;
        j++; 
      }
    }
    else if( invertButton.isSelected() ) {
      j = 0;
      while (j < 625) {
        if (  GrayArray[j] == brightFillColor )
          GrayArray[j] = 0;
        else
          GrayArray[j] = brightFillColor;
        j++; 
      }
    }
    else if( copyButton.isSelected() ) {
      j = 0;
      while (j < 625) {
        Buffer[j] =  GrayArray[j]; 
        j++; 
      }
    }
    else if( pasteButton.isSelected() ) {
      j = 0;
      while (j < 625) {
        GrayArray[j] = Buffer[j]; 
        j++; 
      }
    }
    else if( deleteButton.isSelected() ) {
      // TODO: has error.
      if ( FrameCount > 1)
      {
        FrameCount -= 1;
        DeleteFrame();
 
        if (CurrentFrame > FrameCount)
          CurrentFrame--;
 
        RecallFrame(CurrentFrame);
      }
    }
    else if( previousButton.isSelected() ) {
      if ( CurrentFrame > 1)
      {
        StoreFrame();
        CurrentFrame--;
        RecallFrame(CurrentFrame);
        CurrentDuration = PeggyDurations[CurrentFrame - 1];
      }
    }
    else if( nextButton.isSelected() ) {
      if (CurrentFrame < FrameCount)
      {
        StoreFrame();

        CurrentFrame++;
        RecallFrame(CurrentFrame);
        CurrentDuration = PeggyDurations[CurrentFrame - 1];
      }
    }
    else if( addButton.isSelected() ) {
      FrameCount += 1; 
  
      StoreFrame();
      InsertFrame();   
      CurrentFrame++;
      RecallFrame(CurrentFrame);   //OK thus far...

      CurrentDuration = PeggyDurations[CurrentFrame - 1];
    }
    else if( loadButton.isSelected() ) {
      // Load in the data!
    }
    else if( saveButton.isSelected() ) {
      // Save out the data!
    }
  }
  
/*
  y = cellSize*rows + 105;
  x = 110; 
     if (overRect(x+5, y-18, 75, 18) )
  {
//    text("All frames:", x, y);

   if (SteadyRate)
   SteadyRate = false;
    else
    SteadyRate = true;
} 
  x += 100; 

  x += 35;   
  x += 35;  

if (overRect(x-3, y-18, 20, 18) )
  { 
//    text("+", x, y); 

if (CurrentDuration <= 90)
    CurrentDuration += 10;
else if (CurrentDuration <= 900)
   CurrentDuration += 100;
else if (CurrentDuration <= 59000)
   CurrentDuration += 1000;
else
    CurrentDuration = 60000;
    
if (SteadyRate){
    j = 0;
     while (j < PeggyDurations.length){
      PeggyDurations[j] = CurrentDuration;
  
      j++;
      }
}   
} 
  
 
  x += 15;    
    x += 15; 
     if (overRect(x-3, y-18, 20, 18) )
  { 
//    text("-", x, y);

if (CurrentDuration >= 2000 )
    CurrentDuration -= 1000;
else if (CurrentDuration >= 200 )
    CurrentDuration -= 100;
else if (CurrentDuration >= 20 )
    CurrentDuration -= 10;
else
   CurrentDuration = 10;
   
   
   if (SteadyRate){
    j = 0;
     while (j < PeggyDurations.length){
      PeggyDurations[j] = CurrentDuration;
  
      j++;
      }
}
}

*/

  /*
  // Handle other interface bits here as well! 
   
   if ( buttonSave.over ) {  //Save output file
   String comma = ",";
   
   for (int i = 0; i < rows; i++) {
   // Begin loop for rows
   rowdata = 0;
   for (int j = 0; j < cols; j++) {
   
   if (GrayArray[i*cols + j] > 0)
   {
   rowdata += (1 << j);  
   }
   }
   
   if (i == (rows - 1))
   header = append(header, str(rowdata));
   else
   header = append(header, str(rowdata) + ',');
   }
   FileOutput = concat(header, footer);
   
   File outputDir = new File(sketchPath, "PeggyProgram"); 
   if (!outputDir.exists()) 
   outputDir.mkdirs(); 
   
   saveStrings("PeggyProgram/PeggyProgram.pde", FileOutput);   
   //Note: "/" apparently works as a path separator on all operating systems.
   
   for (int j = 0; j < rows; j++) {
   for (int i = 0; i < cols; i++) { 
   
   }
   }
   }
   */

}

void mouseReleased() {
  pendown = false;
}

// Size of each cell in the grid 
int cellSize = 20; 

// Number of columns and rows in our system
int cols = 25;
int rows = 25;

String[] header;
String[] RowData;
String[] footer;
String[] FileOutput; 
String[] OneRow; 

int[] GrayArray = new int[625];  // Single frame
int[] Buffer = new int[625];    // Clipboard
 

int Brightness;
int j;
byte k; 
boolean pendown = false;
int pencolor; 

int rowdata;

//ImageButtons buttonErase, buttonFill, buttonSave;

PFont font_MB48;
PFont font_MB24;
PFont font_ML16;

SimpleButton clearButton;
SimpleButton fillButton;
SimpleButton invertButton;
SimpleButton copyButton;
SimpleButton pasteButton;
SimpleButton deleteButton;
SimpleButton addButton;
SimpleButton previousButton;
SimpleButton nextButton;
SimpleButton loadButton;
SimpleButton saveButton;

void setup() { 
  
//  UpFrame = false;
   
  PeggyData = new int[625];
  PeggyDurations = new int[1];
  
  PeggyDurations[0]  = 100;
   
  size(cellSize*cols, cellSize*rows + 125 , JAVA2D);
  smooth();
 
  font_MB48  = loadFont("Miso-Bold-48.vlw");
  font_MB24  = loadFont("Miso-Bold-24.vlw");
  font_ML16  = loadFont("Miso-Light-16.vlw"); 

 // textFont( font_MB24, 20);  // MISO Typeface from http://omkrets.se/typografi/

  int x,y;
 
  header = loadStrings("PeggyHeader.txt");
  footer = loadStrings("PeggyFooter.txt");

  colorMode(RGB, 15);    // Max value of R, G, B = 15.
  ellipseMode(CORNER);
  
  j = 0;
  k = 0;

  while (j < 625){
    GrayArray[j] = 0;
    Buffer[j]= 0;
    j++; 
  }

  strokeWeight(1);   
  stroke(StrokeColor);         // Set color: Gray outline for LED locations.
 
  DataX = 15;
  DataY = cellSize*rows +25;
  
  x = 110;
  y = cellSize*rows + 25;
  clearButton = new SimpleButton("Clear", x, y, font_MB24, 24, TextColor, TextHighLight);
  x += 75;
  fillButton = new SimpleButton("Fill", x, y, font_MB24, 24, TextColor, TextHighLight);
  x += 65;
  invertButton = new SimpleButton("Invert", x, y, font_MB24, 24, TextColor, TextHighLight);
  x += 85;
  copyButton = new SimpleButton("Copy", x, y, font_MB24, 24, TextColor, TextHighLight);
  x += 75;
  pasteButton = new SimpleButton("Paste", x, y, font_MB24, 24, TextColor, TextHighLight);
  
  x = 105;
  y = cellSize*rows + 65;
  deleteButton = new SimpleButton("-Frame", x, y, font_MB24, 24, TextColor, TextHighLight);
  x += 85;
  previousButton = new SimpleButton("<<", x, y, font_MB24, 24, TextColor, TextHighLight);
  x +=  45 + 30 + 25 + 45;
  nextButton = new SimpleButton(">>", x, y, font_MB24, 24, TextColor, TextHighLight);
  x += 60;
  addButton = new SimpleButton("+Frame", x, y, font_MB24, 24, TextColor, TextHighLight);
  
  x = 110;
  y = cellSize*rows + 105;
  // toggle button
  x += 100;
  // duration decrease button
  x += 15 + 15;
  // duration increase button
  
  x = 375;
  loadButton = new SimpleButton("Load", x, y, font_MB24, 24, TextColor, TextHighLight);
  x += 65;
  saveButton = new SimpleButton("Save", x, y, font_MB24, 24, TextColor, TextHighLight);

}  // End Setup


void draw() {    

  int mxin, myin;
  int i,j,x,y;

  background(bgColor);
 
  // stroke(StrokeColor);         // Set color: Gray outline for LED locations.

  for ( i = 0; i < cols; i++) {
    // Begin loop for rows
    for ( j = 0; j < rows; j++) {

      if (GrayArray[i*cols + j] > 0)
        fill(brightFillColor); 
      else
        fill(dimFillColor); 

      ellipse(i*cellSize + 1,  j*cellSize + 1, cellSize - 1 , cellSize- 1); 
    }
  }

  fill(8);  
  textFont(font_MB24, 24); 

  if ((mouseX > 0) && (mouseX < cols*cellSize) && (mouseY > 0) && (mouseY < rows*cellSize))
  {

    mxin = floor( mouseX / cellSize);
    myin = floor( mouseY / cellSize); 

    if(mousePressed && pendown)
    {  
      if (pencolor == brightFillColor)
        GrayArray[mxin*cols + myin] = brightFillColor;   
      else
        GrayArray[mxin*cols + myin] = 0;        
    }

    // Position Display:

    fill(8);  
    textFont(font_MB24, 24); 

    if (mxin > 9) 
      text(mxin, DataX - 10, DataY); 
    else
      text(mxin, DataX, DataY); 

    text(",", DataX + 10, DataY);

    if (myin > 9)
      text(myin, DataX + 15, DataY);
    else
      text(myin, DataX + 20, DataY);



  }

  fill(5);  
 textFont(font_ML16, 16); 
 
  x = 10;
  y = cellSize*rows + 110;  
  text("PeggyDraw 2", x, y); 

   textFont(font_MB24, 24);
  fill(TextColor); 

  DrawButtons();  

  textFont(font_ML16, 16);
  fill(TextHighLight);
  String message = new String("");
  
  // Display mouseover text!
  if (clearButton.isSelected()) {
    message = "Erase this frame";
  }
  else if (fillButton.isSelected()) {
    message = "Fill this frame with dots";
  }
  else if (invertButton.isSelected()) {
    message = "Create the negative of this frame";
  }
  else if (copyButton.isSelected()) {
    message = "Don't tell the RIAA or MPAA";
  }
  else if (pasteButton.isSelected()) {
    message = "Less messy than a glue stick";
  }
  else if (deleteButton.isSelected()) {
    message = "DELETE this frame";
  }
  else if (addButton.isSelected()) {
    message = "Add a frame after this frame";
  }
  else if (previousButton.isSelected()) {
    message = "Go to Previous Frame";
  }
  else if (nextButton.isSelected()) {
    message = "Go to Next Frame";
  }
  else if (loadButton.isSelected()) {
    message = "Re-load a saved file";
  }
  else if (saveButton.isSelected()) {
    message = "Export program for Arduino";
  }
  
  if (message != "") {
    text(message, DataX, DataY-10, 75, 100);
  }

  // TODO: remove me
  textFont(font_MB24, 24); 
  fill(TextColor); 

  x = 110;
  y =  cellSize*rows + 25;
 
  x += 75;
  x += 65;  
  x += 85;
  x += 75;


  x = 105;
  y = cellSize*rows + 65;
  x += 85;
  x += 45; 

  text(CurrentFrame, x, y); 
  x += 30;    
  text("/", x, y);
  x += 25;   
  text(FrameCount, x, y);

  x += 45;
  x += 60;
  

  y = cellSize*rows + 105;
  x = 110; 
  
  if (SteadyRate)
  text("All frames: ", x, y);  
  else
  text("This frame: ", x, y);  
   
     if (overRect(x+5, y-18, 75, 18) )
  { 
    //fill(circleColor);
    //rect(x+5, y-18, 75, 18);

    fill(TextHighLight);  

  if (SteadyRate)
  text("All frames: ", x, y);  
  else
  text("This frame: ", x, y);  


    textFont(font_ML16, 16); 

    text("Toggle: All frames or just this one", DataX, DataY-10, 75, 100); 
    textFont(font_MB24, 24); 
    fill(TextColor); 
  } 
  
  
  
  
  
  
  x += 100; 
 
 if (CurrentDuration < 1000){
  text(CurrentDuration, x, y);  
  x += 35;   
  text("ms", x, y); 
 }
 else if (CurrentDuration < 10000)
 {
  x += 10;  
   text(CurrentDuration/1000, x, y);  
  x += 25;   
  text("s", x, y); 
 }
 else {
   text(CurrentDuration/1000, x, y);  
  x += 35;   
  text("s", x, y); 
 }
  
  x += 35;  

text("+", x, y);     
if (overRect(x-3, y-18, 20, 18) )
  { 
    //fill(circleColor);
    //rect(x-3, y-18, 20, 18);

    fill(TextHighLight); 
    text("+", x, y);

    textFont(font_ML16, 16); 

    text("Increase time per frame.", DataX, DataY-10, 75, 100); 
    textFont(font_MB24, 24); 
    fill(TextColor); 
  } 
  
 
  x += 15;    
  text("/", x, y);     
    x += 15; 
 text("-", x, y);   
     if (overRect(x-3, y-18, 20, 18) )
  { 
    //fill(circleColor);
    //rect(x-3, y-18, 20, 18);

    fill(TextHighLight); 
    text("-", x, y);

    textFont(font_ML16, 16); 

    text("Decrease time per frame.", DataX, DataY-10, 75, 100); 
    textFont(font_MB24, 24); 
    fill(TextColor); 
  } 
  
  x = 375;
  x += 65;

} // end main loop 



