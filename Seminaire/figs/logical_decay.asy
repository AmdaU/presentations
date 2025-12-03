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

unitsize(3cm);

usepackage("amssymb");
usepackage("amsmath");

pen curve_width=linewidth(2pt);
pen axis_pen=linewidth(1pt);
int fontsize=20;
int N_points = 100;
real rate = 0.2;
real the_scale = 10;
real X_range = 2;


real[] x;
for (real i = 0; i < X_range; i+=X_range/N_points) {
	x.push(i);
}

// exponential decay
real[] y;
for (int i = 0; i < x.length; ++i) {
	y.push(1/2*(1+exp(-i/(N_points*rate))));
}

draw((0, 0.5)--(X_range, 0.5), dashed+gray(0.5));

draw(graph(x, y), primary+curve_width, "Exponentielle");

xaxis(Label("$t$", position=0.5, align=S), xmin=0, xmax=X_range, p=axis_pen, YEquals(0), Arrow(10));
draw((X_range, 0)--(X_range, 0), axis_pen, arrow=Arrow(10));

yaxis(Label("$\langle \psi | \bar 0 \rangle$",  position=0.5, align=3.5*W), ymin=0, ymax=1.0, above=true, p=axis_pen, ticks=NoTicks);
draw((0, 1.0)--(0, 1.1), axis_pen, arrow=Arrow(10));

ytick(Label("$\frac 1 2$"), 0.5, dir=E, p=axis_pen);
ytick(Label("$1$"), 1.0, dir=E, p=axis_pen);
ytick(Label("$0$"), 0.0, dir=E, p=axis_pen);
draw((0, 1.0)--(0, 1.1), axis_pen, arrow=Arrow(10));

shipoutWithMargin(2mm);


