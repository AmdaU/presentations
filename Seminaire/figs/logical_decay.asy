import settings;
pdfviewer="zathura";
htmlviewer="google-chrome";
outformat="svg";
display="display";
animate="animate";
gs="gs";

import graph;
import geometry;
import math;
include "figs/TN.asy";
include "figs/AutoColors.asy.tmp";

unitsize(5cm);

usepackage("amssymb");
usepackage("amsmath");

pen curve_width=linewidth(2pt);
pen axis_pen=linewidth(1pt);
int fontsize=20;
int N_points = 100;
real rate = 0.1;
real y_scale = 1000;
real x_scale = 10;
real the_scale = 10;
real X_range = 1;


real[] x;
for (real i = 0; i < X_range; i+=X_range/N_points) {
	x.push(i);
}

// exponential decay
real[] y;
for (int i = 0; i < x.length; ++i) {
	y.push(1/2*(1+exp(-i/(N_points*rate))));
}

draw(graph(x, y), primary+curve_width, "Exponentielle");

xaxis(Label("$t$", position=0.5, align=S), xmin=0, xmax=X_range, p=axis_pen, YEquals(0.5));
draw((X_range, 0.5)--(X_range*1.1, 0.5), axis_pen, arrow=Arrow(10));
xaxis(Label("$t$", position=0.5, align=S), xmin=0, xmax=X_range, p=axis_pen, YEquals(0.5));
draw((X_range, 0.5)--(X_range*1.1, 0.5), axis_pen, arrow=Arrow(10));

yaxis(Label("$\langle \psi | \bar 0 \rangle$",  position=0.5, align=W), ymin=0.5, ymax=1.0, above=true, p=axis_pen, ticks=NoTicks);
draw((0, 1.0)--(0, 1.1), axis_pen, arrow=Arrow(10));

ytick(Label("$1/2$", fontsize(fontsize)), 0.5, dir=E, p=axis_pen);
ytick(Label("$1$", fontsize(fontsize)), 1.0, dir=E, p=axis_pen);
draw((0, 1.0)--(0, 1.1), axis_pen, arrow=Arrow(10));

shipoutWithMargin(2mm);


