import settings;
outformat = "svg";
include "figs/TN.asy";
include "figs/AutoColors.asy.tmp";

picture old = currentpicture;
externalLegLength = 20;


legscale = 2;
int dim = 16;

Leg i = makeLeg("i", dim=dim);
Leg i1 = makeLeg("i_1", (0, 1), side=-1, dim=dim);
Leg i2 = makeLeg("i_2", (0, 1), dim=dim);
Leg i3 = makeLeg("i_3", (0, 1), dim=dim);
Leg virt1 = makeLeg("virt1", (1,0), allowBezier=false, labelStrength=0, dim=dim);
Leg virt2 = makeLeg("virt2", (1,0), allowBezier=false, labelStrength=0, dim=dim);
Leg virt3 = makeLeg("virt3", (1,0), allowBezier=false, labelStrength=0, dim=2);
Leg virt4 = makeLeg("virt4", (1,0), allowBezier=false, labelStrength=0, dim=2);

Tensor vector = makeTensor("$v$", (0,0), new Leg[] {i}, primary, "triangle");
Tensor vector_split = makeTensor("$v$", (0,0), new Leg[] {i1, i2}, primary, "circle");
Tensor U = makeTensor("$U$", (0,0), new Leg[] {i1, virt1}, primary, "square");
Tensor S = makeTensor("$S$", (45,0), new Leg[] {virt1, virt2}, tertiary, "diamond", r=0.9*r);
Tensor Vdag = makeTensor("$V^\dagger$", (90,0), new Leg[] {i2, virt2}, primary, "square");
Tensor Up = makeTensor("$$", (0,0), new Leg[] {i1, virt3}, primary, "square");
Tensor Vdagp = makeTensor("$$", (45,0), new Leg[] {i2, virt3, virt4}, primary, "square");
Tensor Vdagpp = makeTensor("$$", (90,0), new Leg[] {i3, dag(virt4)}, primary, "square"); 

TensorNetwork MPS_net = makeTensorNetwork(new Tensor[] {Up, Vdagp, Vdagpp});

picture old = currentpicture;


picture MPS_pic;
currentpicture = MPS_pic;
draw(MPS_net);
shipoutWithMargin(2*lw + 2*gap);

currentpicture = old;



attach(MPS_pic.fit());

shipoutWithMargin(2*lw + 2*gap);