import settings;
pdfviewer="zathura";
htmlviewer="google-chrome";
outformat="svg";
display="display";
animate="animate";
gs="gs";

import graph;
import geometry;
import math;
usepackage("physics");
usepackage("amsmath");
usepackage("amssymb");
usepackage("dsfont");
texpreamble("\input{AutoColors.sty.tmp}");
texpreamble("\renewcommand{\r}{\color{Autosecondary}}");
label("${\r K_i} \in [{\r \mathds{1}}, {\r \hat a}, {\r \hat a^2}, \dotsb, {\r \hat a^i}, \dotsb]$", (0,0), fontsize(18pt));
// shipout(bbox(2mm, background, Fill));
