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
label("$\begin{pmatrix} \begin{matrix} s_{1} & & 0 \\ & \ddots & \\ 0 & & s_{\chi} \end{matrix} & \\ & \begin{matrix} s_{\chi+1} & & 0 \\ & \ddots & \\ 0 & & s_{d} \end{matrix} \end{pmatrix}$", (0,0), fontsize(18pt));
// shipout(bbox(2mm, background, Fill));