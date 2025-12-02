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
Leg virt1 = makeLeg("virt1", (1,0), allowBezier=false, labelStrength=0, dim=dim);
Leg virt2 = makeLeg("virt2", (1,0), allowBezier=false, labelStrength=0, dim=dim);
Leg virt3 = makeLeg("virt3", (1,0), allowBezier=false, labelStrength=0, dim=2);

Tensor vector = makeTensor("$v$", (0,0), new Leg[] {i}, primary, "triangle");
Tensor vector_split = makeTensor("$v$", (0,0), new Leg[] {i1, i2}, primary, "circle");
Tensor U = makeTensor("$U$", (0,0), new Leg[] {i1, virt1}, primary, "square");
Tensor S = makeTensor("$S$", (45,0), new Leg[] {virt1, virt2}, tertiary, "diamond", r=0.9*r);
Tensor Vdag = makeTensor("$V^\dagger$", (90,0), new Leg[] {i2, virt2}, primary, "square");
Tensor Up = makeTensor("$U$", (0,0), new Leg[] {i1, virt3}, primary, "square");
Tensor Vdagp = makeTensor("$V^\dagger$", (45,0), new Leg[] {i2, virt3}, primary, "square");

TensorNetwork vector_net = makeTensorNetwork(new Tensor[] {vector});
TensorNetwork vector_split_net = makeTensorNetwork(new Tensor[] {vector_split});
TensorNetwork svd_net = makeTensorNetwork(new Tensor[] {U, S, Vdag});
TensorNetwork MPS_net = makeTensorNetwork(new Tensor[] {Up, Vdagp});

picture old = currentpicture;

picture vector_pic;
currentpicture = vector_pic;
draw(vector_net);
shipoutWithMargin(2*lw + 2*gap);

picture vector_split_pic;
currentpicture = vector_split_pic;
draw(vector_split_net);
shipoutWithMargin(2*lw + 2*gap);



picture svd_pic;
currentpicture = svd_pic;

real slash_length = 25;
real slash_width = 3;
real slash_offset = 6;
pair pos = S.pos;

draw(svd_net);
// slash through S
draw(pos+(slash_offset,-slash_length/2)--(pos+(slash_offset,slash_length/2)), dashed+secondary+linewidth(slash_width));
draw(pos+(-slash_length/2,-slash_offset)--(pos+(slash_length/2,-slash_offset)), dashed+secondary+linewidth(slash_width));

// slash through Vdag
pos = Vdag.pos;
draw(pos+(slash_offset,-slash_length/2)--(pos+(slash_offset,slash_length/2)), dashed+secondary+linewidth(slash_width));
// slash through U
pos = U.pos;
draw(pos+(-slash_length/2,-slash_offset)--(pos+(slash_length/2,-slash_offset)), dashed+secondary+linewidth(slash_width));

shipoutWithMargin(2*lw + 2*gap);

picture MPS_pic;
currentpicture = MPS_pic;
draw(MPS_net);
shipoutWithMargin(2*lw + 2*gap);

currentpicture = old;


pair total_offset = (100,0);
picture[] pics = new picture[] {vector_pic, vector_split_pic, svd_pic, MPS_pic};
//picture[] pics = new picture[] {svd_pic, MPS_pic};
for (int i = 0; i < pics.length; i+=1) {
  attach(pics[i].fit(), total_offset);
  if (i < pics.length - 1) {
  	pair a = total_offset + (max(pics[i]).x, 0);
	pair b = total_offset + (max(pics[i]).x,0) + (30,0);
    draw(a--b, black + linewidth(1.5), arrow=Arrow(TeXHead, size=1mm));
  }
	total_offset += (max(pics[i]).x, 0);
	total_offset += (60, 0);
}
shipoutWithMargin(2*lw + 2*gap);