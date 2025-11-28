import settings;
outformat = "svg";


include "figs/TN.asy";
include "figs/AutoColors.asy.tmp";


picture old = currentpicture;
externalLegLength = 15;

int N = 5; 
real dist = 40;
int fontsize = 30;

Leg i = makeLeg("a", dir=(0, -1), side=-1);
Leg j = makeLeg("b", dir=(0, -1), side=-1);
Leg k = makeLeg("c", dir=(0, -1), side=-1);
Leg l = makeLeg("d");



Tensor T = makeTensor("$T$", (0,0), new Leg[] {i, j, k, l}, tertiary, "rect", ratio=0.5, r=30);
label("$T^d_{abc} \rightarrow$", (-30,0), align=W, fontsize(fontsize));

TensorNetwork net = makeTensorNetwork(new Tensor[] {T});
draw(net);
shipoutWithMargin(2*lw + 2*gap);
