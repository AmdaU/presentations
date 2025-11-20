include "figs/TN.asy";
include "figs/AutoColors.asy.tmp";

picture old = currentpicture;
externalLegLength = 15;

int N = 5; 
real dist = 40;

pen background = background_light;

Leg[] is = new Leg[N];
Leg[] virts = new Leg[N];
Leg[] is_p = new Leg[N];
Leg[] is_pp = new Leg[N];

for (int n = 0; n < N; n+=1) {
  is[n] = makeLeg("i_" + string(n), (0, 1), labelStrength=0);
  is_p[n] = makeLeg("i_" + string(n) + "'", (0, 1), side=-1, labelStrength=0);
  is_pp[n] = makeLeg("i_" + string(n) + "''", (0, 1), side=-1, labelStrength=0);
}
for (int n = 0; n < N-1; n+=1) {
  virts[n] = makeLeg("virt_" + string(n), (1,0), allowBezier=false, labelStrength=0);
}

Tensor[] Ts = new Tensor[N];
//Ts[0] = makeTensor("$T_{0}$", (0,0), new Leg[] {is[0], virts[0]}, primary, "circle");
Ts[0] = makeTensor("", (0,0), new Leg[] {is[0], virts[0]}, mainblue, "circle");

for (int n = 1; n < N-1; n+=1) {
  //Ts[n] = makeTensor("$T_{" + string(n) + "}$", (n*dist,0), new Leg[] {is[n], virts[n - 1], virts[n]}, primary, "circle");
  Ts[n] = makeTensor("", (n*dist,0), new Leg[] {is[n], virts[n - 1], virts[n]}, mainblue, "circle");
}
//Ts[N-1] = makeTensor("$T_{" + string(N-1) + "}$", ((N-1)*dist,0), new Leg[] {is[N-1], virts[N-2]}, primary, "circle");
Ts[N-1] = makeTensor("", ((N-1)*dist,0), new Leg[] {is[N-1], virts[N-2]}, mainblue, "circle");

Tensor[] ops;
Leg[][] op_legs = new Leg[N-1][4];
op_legs[0] = new Leg[] {dag(is[0]), is_p[0], dag(is[1]), is_p[1]};
for (int n = 1; n < N-1; n+=1) {
  op_legs[n] = new Leg[] {dag(is_p[n]), dag(is[n+1]), is_pp[n], is_p[n+1]};
}
for (int n = 0; n < N-1; n+=1) {
  ops[n] = makeTensor("", ((n+0.5)*dist,(n+1)*dist), op_legs[n], mainred, "rect", r=2/3*dist, ratio=0.5);
}

// join ops with Ts


TensorNetwork net = makeTensorNetwork(concat(Ts, ops));
draw(net);
shipout(bbox(2mm, background, Fill));
