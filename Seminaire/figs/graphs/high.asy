include "figs/graphs/graphs_common.asy";
include "figs/AutoColors.asy.tmp";

outformat="svg";

size(600, 300, IgnoreAspect);


string data_file="figs/graphs/logical_value_curves_high.csv";

real[][] data=get_data(data_file);
// keep only the first 3 columns
real[] curve_gkp=data[0], curve_qubit=data[1], curve_repetition=data[2], curve_repetition_x_gkp=data[3];
real[][] data = {curve_qubit, curve_repetition, curve_repetition_x_gkp};
draw_graphs(data, new pen[]{primary, secondary, tertiary}, new string[]{"Qubit", "Repetition", "Repetition $\otimes$ GKP"});


shipout(bbox(1cm, 0.1cm, nullpen));
