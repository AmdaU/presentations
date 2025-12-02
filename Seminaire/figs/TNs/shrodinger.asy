import settings;
outformat = "svg";


include "figs/TN.asy";
include "figs/AutoColors.asy.tmp";

usepackage("amsmath");
usepackage("physics");
usepackage("amssymb");
texpreamble("\input{AutoColors.sty.tmp}");

picture old = currentpicture;
externalLegLength = 15;

int N = 1; 
real dist = 40;
int fontsize = 30;
real r_outer = 50;
real r_inner = 30;
real straight_length = 20;

Leg[] legs = new Leg[N];
Leg[] legsPrime = new Leg[N];
for (int n = 0; n < N; n+=1) {
  legs[n] = makeLeg("i_" + string(n), dir=(0, 1), side=-1);
  legsPrime[n] = makeLeg("i'_" + string(n), dir=(0, 1), side=-1, labelStrength=0);
}

Tensor[] psis = new Tensor[N];
Tensor[] ops = new Tensor[N];
for (int n = 0; n < N; n+=1) {
  psis[n] = makeTensor("$\psi$", (n*dist,0), new Leg[] {legs[n]}, primary, "circle");
  ops[n] = makeTensor("$U$", (n*dist,dist), new Leg[] {dag(legs[n]), legsPrime[n]}, secondary, "circle");
}

// label("$\dotsb$", (dist*(N),dist/2 + externalLegLength/2), fontsize(fontsize));

//  label(scale(3.5)*"$\{$", (0,dist/2 + externalLegLength/2), align=W, fontsize(fontsize));

//  label(scale(3.5)*"$\}$", (dist*N,dist/2 + externalLegLength/2), align=E, fontsize(fontsize));

TensorNetwork net = makeTensorNetwork(concat(psis, ops));
draw(net);
shipoutWithMargin(2*lw + 2*gap);
