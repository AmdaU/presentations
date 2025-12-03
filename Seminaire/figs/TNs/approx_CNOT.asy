import settings;
outformat = "svg";


include "figs/TN.asy";
include "figs/AutoColors.asy.tmp";


picture old = currentpicture;
externalLegLength = 15;

int N = 5; 
real dist = 40;
int fontsize = 30;

Leg i = makeLeg("i", dir=(0, -1), side=-1, labelStrength=0);
Leg j = makeLeg("j", dir=(0, -1), side=-1, labelStrength=0);
Leg k = makeLeg("k", labelStrength=0);
Leg l = makeLeg("l", labelStrength=0);


Tensor A = makeTensor("$\approx$CNOT", (0,0), new Leg[] {i, j, k, l}, secondary, "rect", ratio=0.3, r=30);


TensorNetwork net = makeTensorNetwork(new Tensor[] {A});
// label("$A^j_{i} \rightarrow$", (-15,0), align=W, fontsize(fontsize));
draw(net);
shipoutWithMargin(2*lw + 2*gap);
