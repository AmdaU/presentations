include "figs/graphs/graphs_common.asy";
include "figs/AutoColors.asy.tmp";

outformat="svg";

size(600, 300, IgnoreAspect);



string data_file="figs/graphs/logical_value_curves_medium.csv";


real[][] data=get_data(data_file);
real[] curve_qubit=data[0], curve_repetition=data[1], curve_repetition_x_gkp=data[2], curve_repetition_x_gkp_corr=data[3];

//data = new real[][] {curve_qubit, curve_repetition, curve_repetition_x_gkp, curve_repetition_x_gkp_corr};
data = new real[][] {curve_qubit, curve_repetition, curve_repetition_x_gkp};

//draw_graphs(data, new pen[]{primary, secondary, tertiary, primary}, new string[]{"Qubit", "Repetition", "Repetition $\otimes$ GKP", "Repetition $\otimes$ GKP - Correction"});
draw_graphs(data, new pen[]{primary, secondary, tertiary}, new string[]{"Qubit", "Repetition", "Repetition $\otimes$ GKP"});