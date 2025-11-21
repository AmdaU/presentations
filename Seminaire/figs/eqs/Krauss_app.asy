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
label("$\ket{\psi} \to S_i \ket{\psi} \text{ avec probabilité } p_i = \bra{\psi} S_i^\dagger S_i \ket{\psi}$", (0,0), fontsize(18pt));
// shipout(bbox(2mm, background, Fill));