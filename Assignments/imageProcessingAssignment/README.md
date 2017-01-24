this program contains three core methods of image editing.

The effect are...

  WhiteNoise;     Creates a dynamic white noise effect on top of an image. The opacity of the effect can then be lowered or raised.
                  This is done by pressing on the mouse, and dragging it to a random location. The program calculates the X distance
                  between when the mouse is pressed and when it's released to adjust the opacity. 
              
  Edge Detection; calculates edge pixels and creates hard hard shifts between 0 and 255. This is only achieved by clicking once,
                  and then clicking again somewhere else on the image. The program will then establish a rect according to both
                  X/Y coordinances allowing the effect to visualize. 
                  
  Blend Modes;    This effect will shift between the 14 default blending modes provided by processing. 2 images at a minimum are
                  needed to achieve an effect. 
                  
                  
 Controls...
 
  To shift between the 3 different effects, press c/C
  To shift between the 14 Blend Modes effects, press b/B OR mousePressed
  To save an image, press s/S
              
