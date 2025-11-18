include "figs/TN.asy";
include "figs/AutoColors.asy.tmp";

externalLegLength = 20;

Leg i = makeLeg("i", (1, 0), allowBezier=false);
Leg ip = makeLeg("i'", (1, 0));

Tensor A = makeTensor("$\psi$", (0,0), new Leg[] {i}, primary, "triangle");
Tensor B = makeTensor("$M$", (45,0), new Leg[] {i, ip}, secondary, "square");


TensorNetwork net = makeTensorNetwork(new Tensor[] {A, B});
draw(net);
shipoutWithMargin(2*lw + 2*gap);