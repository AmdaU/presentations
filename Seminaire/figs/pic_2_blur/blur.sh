#!/bin/bash
magick how.png -region "65%x65%+%[fx:w*0.33]+%[fx:h*0.25]" -gaussian-blur 0x15 how_blur1.png
magick how.png -region "32%x65%+0+%[fx:h*0.25]" -gaussian-blur 0x15 -region "35%x65%+%[fx:w*0.63]+%[fx:h*0.25]" -gaussian-blur 0x15 how_blur2.png
magick how.png -region "63%x65%+0+%[fx:h*0.25]" -gaussian-blur 0x15 how_blur3.png
magick how.png -region "97%x65%+0+%[fx:h*0.25]" -gaussian-blur 0x15 how_blur4.png
magick 4_sisters.png -region "58%x95%+%[fx:w*0.4]+%[fx:h*0.02]" -gaussian-blur 0x15 4_sisters_blur.png
magick 4_sisters.png -region "38%x95%+%[fx:w*0.02]+%[fx:h*0.02]" -gaussian-blur 0x15 4_sisters_blur2.png
