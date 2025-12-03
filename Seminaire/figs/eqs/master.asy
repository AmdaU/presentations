import settings;
pdfviewer="zathura";
htmlviewer="google-chrome";
outformat="svg";
display="display";
animate="animate";
gs="gs";
include "figs/AutoColors.asy.tmp";



import graph;
import geometry;
import math;
usepackage("amsmath");
usepackage("physics");
usepackage("amssymb");
texpreamble("\input{AutoColors.sty.tmp}");
// the rho in the text is of color secondary
texpreamble("\renewcommand{\r}{\color{Autosecondary}}");
texpreamble("\renewcommand{\b}{\color{Autoprimary}}");
label("$\dot{\b \rho}(t) = -\frac{i}{\hbar} [{\r H}, {\b \rho}(t)] + {\r \mathcal{D}} {\b \rho}(t) = {\r \mathcal{L}} {\b \rho}(t)$", (0,0), fontsize(18pt));
// shipout(bbox(2mm, background, Fill));