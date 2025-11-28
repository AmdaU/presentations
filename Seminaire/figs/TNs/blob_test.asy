import settings;
outformat = "svg";


include "figs/TN.asy";
include "figs/AutoColors.asy.tmp";


picture old = currentpicture;
externalLegLength = 15;

int N = 5; 
real dist = 40;
int fontsize = 30;
real r_outer = 50;
real r_inner = 30;
real straight_length = 20;

Leg i = makeLeg("i", dir=(0, -1), side=-1);
Leg j = makeLeg("j");
Leg i_2 = makeLeg("i'", dir=(0, -1), side=-1);
Leg j_2 = makeLeg("j'");

Tensor rho = makeTensor("$\rho$", (0,0), new Leg[] {i, j}, primary, "circle");
// make a path that makes a closed C shape around the circle with two nested arcs
path c_outer = arc((0,0), r_outer, -90, 90);
path c_inner = arc((0,0), r_inner, 90, -90);
// join the outer and inner arcs with a smaller arc
path c_link = arc((0,(r_outer+r_inner)/2), (r_outer-r_inner)/2, -270, 270);
path c_link_2 = shift((0,-(r_outer+r_inner)))*c_link;

c_link = shift((-straight_length/2,0))*c_link;
c_link_2 = shift((-straight_length/2,0))*c_link_2;

path c = c_outer -- c_link -- c_inner -- c_link_2 -- cycle;


pair port_i = (0, -r_inner);
pair port_j = (0, r_inner);
pair port_i_2 = (0, -r_outer);
pair port_j_2 = (0, r_outer);
Tensor so = makeTensor("$\mathcal{L}$", (0,0), new Leg[] {dag(i), dag(j), i_2, j_2}, secondary, "blob", blob=c, blob_ports=new pair[] {port_i, port_j, port_i_2, port_j_2}, blob_label_pos=((r_outer+r_inner)/2,0));



TensorNetwork net = makeTensorNetwork(new Tensor[] {so, rho});
// label("$A^j_{i} \rightarrow$", (-15,0), align=W, fontsize(fontsize));
draw(net);
shipoutWithMargin(2*lw + 2*gap);
