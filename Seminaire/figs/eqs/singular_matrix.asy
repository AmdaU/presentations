import settings;
pdfviewer="zathura";
htmlviewer="google-chrome";
outformat="svg";
display="display";
animate="animate";
gs="gs";

usepackage("amsmath");
usepackage("amssymb");

import graph;
import geometry;
import math;
label("$\begin{pmatrix} s_1 & 0 & 0 & \dotsb \\ 0 & s_2 & 0 & \dotsb \\ 0 & 0 & s_3 & \dotsb \\ 0 & 0 & 0 & \dotsb \\ 0 & 0 & 0 & \dotsb \\\vdots & \vdots & \vdots & \ddots \end{pmatrix}$", (0,0), fontsize(18pt));
// shipout(bbox(2mm, background, Fill));