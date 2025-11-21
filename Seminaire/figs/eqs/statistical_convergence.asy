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
label("$\sum_{n} \langle \psi_{\rm final, n} | \hat O| \psi_{\rm final, n} \rangle = \text{Tr}(\hat O \rho_{\rm final})$", (0,0), fontsize(18pt));
// shipout(bbox(2mm, background, Fill));