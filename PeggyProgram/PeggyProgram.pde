/* Simple example code for Peggy 2.0, using the Peggy2 library, version 0.2.
 
 Designed to be automatically generated!
 
 Copyright (c) 2008 Windell H Oskay.  All right reserved.
 
 This example is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2.1 of the License, or (at your option) any later version.
 
 This software is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public
 License along with this software; if not, write to the Free Software
 Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */

#include <Peggy2.h>
#include <math.h>
#include <stdlib.h> 

Peggy2 frame1;     // Make a frame buffer object, called frame1 

unsigned long data1[25] = {
0,
262144,
1048592,
2097160,
4194308,
65540,
2,
0,
0,
32,
32784,
196624,
24,
131080,
655464,
575016,
50696,
8406024,
8388608,
5243008,
7864324,
3932168,
1835024,
393216,
24576
};



void setup()                    // run once, when the sketch starts
{
  frame1.HardwareInit();   // Call this once to init the hardware. 
  // (Only needed once, even if you've got lots of frames.)

  unsigned short y = 0;     

  while (y < 25) {


    frame1.WriteRow( y, data1[y]); 

    y++;

  }


}  // End void setup()  


void loop()                     // run over and over again
{ 

  frame1.RefreshAll(10); //Draw frame buffer 10 times 

}
