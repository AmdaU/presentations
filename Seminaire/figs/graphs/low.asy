import graph;
import settings;

include "figs/AutoColors.asy.tmp";
include "figs/graphs/graphs_common.asy";

outformat="svg";


size(600, 300, IgnoreAspect);
pen curve_width=linewidth(2pt);
pen axis_pen=linewidth(1pt);


real[] curve_qubit;
real[] curve_repetition;
real[] curve_repetition_x_gkp;
real[] curve_repetition_x_gkp_corr;

string data_file="figs/graphs/logical_value_curves_low.csv";

real[][] data=get_data(data_file);

real[] curve_gkp=data[0], curve_repetition=data[1], curve_repetition_x_gkp=data[2], curve_repetition_x_gkp_corr=data[3];
// make x range from 0 to the length of the data
int[] x;
for (int i = 1; i <= curve_gkp.length; ++i) x.push(i);


// draw(graph(x, curve_gkp), primary+curve_width);
// draw(graph(x, curve_qubit), primary+curve_width, "Qubit");
// draw(graph(x, curve_repetition), secondary+curve_width, "Repetition");
// draw(graph(x, curve_repetition_x_gkp), tertiary+curve_width, "Repetition $\otimes$ GKP");
// draw(graph(x, curve_repetition_x_gkp_corr), quaternary+curve_width, "Repetition $\otimes$ GKP - Correction");

//xrange from 1 to the length of the data

xaxis("steps", Bottom, LeftTicks, xmin=0, xmax=x.length,p=axis_pen);
yaxis(rotate(90)*"$c_0$", Left, RightTicks, ymin=0.5, ymax=1, above=true,p=axis_pen);

// make a legend

add(legend(nullpen), point(NE), SW, UnFill);

shipout(bbox(1cm, 0.1cm, nullpen));
