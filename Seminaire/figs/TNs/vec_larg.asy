include "figs/TN.asy";
include "figs/AutoColors.asy.tmp";

picture old = currentpicture;
externalLegLength = 15;

int N = 5; 
real dist = 40;

Leg i = makeLeg("i", dim=16);

Tensor T = makeTensor("", (0,0), new Leg[] {i}, primary, "circle");


TensorNetwork net = makeTensorNetwork(new Tensor[] {T});
draw(net);
shipoutWithMargin(2*lw + 2*gap);
