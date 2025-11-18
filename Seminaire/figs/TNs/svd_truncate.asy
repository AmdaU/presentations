include "figs/TN.asy";
include "figs/AutoColors.asy.tmp";

picture old = currentpicture;
externalLegLength = 20;


Leg i = makeLeg("i");
Leg i1 = makeLeg("i_1", (-0.5, 1), side=-1);
Leg i2 = makeLeg("i_2", (0.5, 1));
Leg virt1 = makeLeg("virt1", allowBezier=false, labelStrength=0);
Leg virt2 = makeLeg("virt2", allowBezier=false, labelStrength=0);
Leg virt3 = makeLeg("virt3", allowBezier=false, labelStrength=0);

Tensor vector = makeTensor("$v$", (0,0), new Leg[] {i}, primary, "triangle");
Tensor vector_split = makeTensor("$v$", (0,0), new Leg[] {i1, i2}, primary, "circle");
Tensor U = makeTensor("$U$", (0,0), new Leg[] {i1, virt1}, primary, "square");
Tensor S = makeTensor("$S$", (45,0), new Leg[] {virt1, virt2}, tertiary, "diamond");
Tensor Vdag = makeTensor("$V^\dagger$", (90,0), new Leg[] {i2, virt2}, secondary, "square");
Tensor Up = makeTensor("$U$", (0,0), new Leg[] {i1, virt3}, primary, "square");
Tensor Vdagp = makeTensor("$V^\dagger$", (45,0), new Leg[] {i2, virt3}, secondary, "square");

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
draw(svd_net);
shipoutWithMargin(2*lw + 2*gap);

picture MPS_pic;
currentpicture = MPS_pic;
draw(MPS_net);
shipoutWithMargin(2*lw + 2*gap);

currentpicture = old;


pair total_offset = (100,0);
picture[] pics = new picture[] {vector_pic, vector_split_pic, svd_pic, MPS_pic};
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