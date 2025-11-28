import settings;
outformat = "svg";


include "figs/TN.asy";
include "figs/AutoColors.asy.tmp";


picture old = currentpicture;
externalLegLength = 15;

int N = 5; 
real dist = 40;
int fontsize = 30;

Leg i = makeLeg("i");


Tensor T = makeTensor("$\psi$", (0,0), new Leg[] {i}, primary, "circle");


TensorNetwork net = makeTensorNetwork(new Tensor[] {T});
label("$\psi_i \rightarrow$", (-30,0), align=W, fontsize(fontsize));
draw(net);
shipoutWithMargin(2*lw + 2*gap);
