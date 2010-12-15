import processing.serial.*;
 
class livePreview
{
  Serial serial;
 
  int ledWidth = 14;
  int ledHeight = 9;
  int ledFrameSize = 9*2;
  
  livePreview(PApplet parent, String portName) {
    serial = new Serial(parent, portName, 115200);
  }
  
  void displayAnimationFrame(AnimationFrame displayFrame) {
    char[] frame = new char[ledFrameSize];
    
    // Grab a 14x9 window
    for (int row = 0; row < ledHeight; row++) {
      char buf = 0;
      for (int col = 0; col < 8; col++) {
        buf = (char)(buf << 1);
        buf |= (displayFrame.getPixel(col,row)>1) ? 1:0;
//        buf |= (col%2);
      }
      frame[row*2] = buf;               
 
      for (int col = 0; col < 6; col++) {
        buf = (char)(buf << 1);
        buf |= (displayFrame.getPixel(col+8,row)>1) ? 1:0;
//        buf |= (col%2);
      }
      buf = (char)(buf << 2);
 
      frame[row*2+1] = buf;
    }
 
    sendFrame(frame);
  }
  

  void sendFrame(char[] frame) {
    byte[] magicNumber = {0x12, 0x34, 0x56, 0x78, 0x1, 0x0};
 
    serial.write(magicNumber);
 
    // TODO: Drop 9*2 magic number
    for(int index = 0; index < ledFrameSize; index++) {
      serial.write(frame[index]);
    }
  }
}
