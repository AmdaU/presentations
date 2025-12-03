include "figs/graphs/graphs_common.asy";
include "figs/AutoColors.asy.tmp";

outformat="svg";

size(600, 300, IgnoreAspect);


string data_file="figs/graphs/logical_value_curves_high.csv";

real[] curve_qubit;
real[] curve_repetition;
real[] curve_repetition_x_gkp;
real[] curve_repetition_x_gkp_corr;

string data="figs/graphs/logical_value_curves_high.csv";

file in=input(data).line().csv();

string[] titlelabel=in;
string[] columnlabel=in;

real[][] data = in;


real[][] data=get_data(data_file);
real[] curve_qubit=data[0], curve_repetition=data[1], curve_repetition_x_gkp=data[2], curve_repetition_x_gkp_corr=data[3];
// make x range from 0 to the length of the data

data = new real[][] {curve_qubit, curve_repetition, curve_repetition_x_gkp, curve_repetition_x_gkp_corr};

draw_graphs(data, new pen[]{primary, secondary, tertiary, primary}, new string[]{"Qubit", "Repetition", "Repetition $\otimes$ GKP", "Repetition $\otimes$ GKP - Correction"});

shipout(bbox(1cm, 0.1cm, nullpen));
