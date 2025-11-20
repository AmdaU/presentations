import settings;
// outformat = "pdf";
htmlviewer="/usr/bin/chromium-browser";
//import graph3 -----------------------------------------------------------------------------
import graph;
include "figs/AutoColors.asy.tmp";

real img_size = 100;
size(img_size);
srand(2);

// parameters
bool darkmode = false;
int num_graphs = 50;
pen accent = mainblue;
pen accent2 = mainred;
pen background = background_light;
// very light grey
pen mix_pen(pen p1, pen p2, real ratio){
	return p1 * ratio + p2 * (1-ratio);
}

pen arc_pen = linewidth(img_size * 0.01) + accent;
pen main_axis_pen = linewidth(img_size * 0.01);
pen secondary_axis_pen = linewidth(img_size * 0.005)+rgb(0.3,0.3,0.3);
pen box_pen = linewidth(img_size * 0.005);
pen transparent = nullpen;
real fontsize = 30;

real r = 0.02;
real sr = 0.01;


real a = 30;

pair v = (0.4, 0.7);


pair v1 = rotate(a)*(0,1);
pair v2 = rotate(a)*(1,0);

pair i_v1 = dot(v1, v) * v1;
pair i_v2 = dot(v2, v) * v2;

draw((0,0)--v1, secondary_axis_pen, Arrow(3));
draw((0,0)--v2, secondary_axis_pen, Arrow(3));

draw(arc((0,0), 0.3, 0, a), arc_pen);


draw((0,0)--(0,1), main_axis_pen, Arrow(3));
draw((0,0)--(1,0), main_axis_pen, Arrow(3));


draw(v--(0,v.y), accent2 + dashed);
draw(v--(v.x,0), accent2 + dashed);
fill(circle((0,v.y), sr), accent2);
fill(circle((v.x,0), sr), accent2);

fill(circle(i_v1, sr), accent);
fill(circle(i_v2, sr), accent);

draw(i_v1--v, accent + dashed);
draw(i_v2--v, accent + dashed);


fill(circle(v, r), accent2);


// label("$\pi$ = " + string(4 * n_inside / (n_inside + n_outside)), (0.5,0.5));
shipout(bbox(2mm, background, Fill));
