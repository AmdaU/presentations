import settings;
outformat = "svg";


include "figs/TN.asy";
include "figs/AutoColors.asy.tmp";


picture old = currentpicture;
externalLegLength = 15;

int N = 5; 
real dist = 40;
int fontsize = 30;

Leg i = makeLeg("i", dir=(0, -1), side=-1);
Leg j = makeLeg("j");


Tensor A = makeTensor("$A$", (0,0), new Leg[] {i, j}, secondary, "rect");


TensorNetwork net = makeTensorNetwork(new Tensor[] {A});
label("$A^j_{i} \rightarrow$", (-30,0), align=W, fontsize(fontsize));
draw(net);
shipoutWithMargin(2*lw + 2*gap);
