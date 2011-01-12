/*   
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
 
 

class AnimationLoader
{
  /*
  String[] header;
  String[] RowData;
  String[] footer;
  String[] FileOutput; 
  String[] OneRow; 
  */

  AnimationLoader() {
    
    /*
    header = loadStrings("PeggyHeader.txt");
    footer = loadStrings("PeggyFooter.txt");
    */

  }
 
  AnimationFrames LoadAnimation(String filename) {
    println("Loading animation from: " + filename);
    
    // Create a new animation
    AnimationFrames animation = new AnimationFrames(cols, rows);
    
    // For demonstration: let's make a generative animation with this many frames
    int demoAnimationFrameCount = 2;
    
    
    int i = 0;
    
    // Repeat while there are still frames to load
    while(i < demoAnimationFrameCount) {
      
      // For demonstration: buld a fake frame
      int[] frameData = new int[rows*cols];
      for (int j = 0; j < frameData.length; j++) {
        frameData[j] = (i + j) % 2;
      }
      int duration = i;
      
      // Add the frame to the end of our animation
      animation.addFrame(new AnimationFrame(cols, rows, frameData, duration), animation.getFrameCount());
     
      // For demonstration: advance to next fake frame
      i++;
    }
    
    return animation;
  }
  
  void SaveAnimation(String filename, AnimationFrames animation) {
    println("Saving animation to: " + filename);
  
    // For each frame
    for (int i = 0; i < animation.getFrameCount(); i++) {
      println("Frame: " + i);
      
      // Load the frame data
      int data[] = animation.getFrame(i).getFrameData();
      
      // Handle the frame data
      for (int j = 0; j < data.length; j++) {
        print(data[j] > 0 ?"o":" ");
        
        if ((j + 1) % cols == 0) {
          print("\n");
        }
      }
      
      print("\n");
    }
  }
}
