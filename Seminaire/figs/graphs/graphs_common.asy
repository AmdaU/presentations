import graph;
import settings;

include "figs/AutoColors.asy.tmp";
usepackage("amsmath");
usepackage("amssymb");
usepackage("physics");

outformat="svg";

size(600, 300, IgnoreAspect);
pen curve_width=linewidth(2pt);
pen axis_pen=linewidth(1pt);
int fontsize=20;

real y_min=0.4;

real[] curve_gkp;
real[] curve_repetition;
real[] curve_repetition_x_gkp;
real[] curve_repetition_x_gkp_corr;

// function that returns a list of lists of data
real[][] get_data(string data_file){
	file in=input(data_file).line().csv();
	string[] titlelabel=in;
	string[] columnlabel=in;
	real[][] data = in;

	data = transpose(data);
	return data;
}


void draw_graphs(real[][] data, pen[] colors, string[] labels){
	int[] x;
	for (int i = 1; i <= data[0].length; ++i) {x.push(i);}
	
	//add a dashed line at y=0.5
	draw((0,0.5)--(x.length,0.5), dashed+gray(0.5));

	for (int i = 0; i < data.length; ++i){
		draw(graph(x, data[i]), colors[i]+curve_width, labels[i]);
	}

	xaxis(Label("$t$", fontsize(fontsize), position=0.5, align=S), YEquals(y_min), xmin=0, xmax=x.length, p=axis_pen, Arrow(10));
	yaxis(Label("$\langle \psi | \bar 0 \rangle$", fontsize(fontsize)), Left, RightTicks, ymin=y_min, ymax=1, above=true,p=axis_pen, Arrow(10));



	// make a legend
	add(legend(nullpen), point(E), W, UnFill);

}
