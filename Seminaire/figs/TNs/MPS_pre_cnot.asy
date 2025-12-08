import settings;
outformat = "svg";
include "figs/TN.asy";
include "figs/AutoColors.asy.tmp";

picture old = currentpicture;
externalLegLength = 15;
legscale = 4;
int N = 6; 
real dist = 40;
int site_dim = 20;

Leg[] is = new Leg[N];
Leg[] virts = new Leg[N];
for (int n = 0; n < N; n+=1) {
  int side = 1;
  if (n == 0) {
    side = -1;
  }
  is[n] = makeLeg("i_" + string(n), (0, 1), side=side, dim=site_dim);
}
for (int n = 0; n < N-1; n+=1) {
  virts[n] = makeLeg("virt_" + string(n), (1,0), allowBezier=false, labelStrength=0, dim=2^(1+min(n, N-n-2)));
}

Tensor[] Ts = new Tensor[N];
//Ts[0] = makeTensor("$T_{0}$", (0,0), new Leg[] {is[0], virts[0]}, primary, "circle");
Ts[0] = makeTensor("", (0,0), new Leg[] {is[0], virts[0]}, primary, "circle");

for (int n = 1; n < N-1; n+=1) {
  //Ts[n] = makeTensor("$T_{" + string(n) + "}$", (n*dist,0), new Leg[] {is[n], virts[n - 1], virts[n]}, primary, "circle");
  Ts[n] = makeTensor("", (n*dist,0), new Leg[] {is[n], virts[n - 1], virts[n]}, primary, "circle");
}
//Ts[N-1] = makeTensor("$T_{" + string(N-1) + "}$", ((N-1)*dist,0), new Leg[] {is[N-1], virts[N-2]}, primary, "circle");
Ts[N-1] = makeTensor("", ((N-1)*dist,0), new Leg[] {is[N-1], virts[N-2]}, primary, "circle");

Leg i0p = makeLeg("i_0'", (0, 1), side=-1, dim=site_dim);
Leg i1p = makeLeg("i_1'", (0, 1), dim=site_dim);

Tensor Cnot = makeTensor("CNOT", (dist/2,dist), new Leg[] {i0p, i1p, dag(is[0]), dag(is[1])}, secondary, "rect", ratio=0.4, r=40);



TensorNetwork net = makeTensorNetwork(Ts);
draw(net);
shipoutWithMargin(2*lw + 2*gap);