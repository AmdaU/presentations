import settings;
// outformat = "pdf";
htmlviewer="/usr/bin/chromium-browser";
//import graph3 -----------------------------------------------------------------------------
import graph;
include "figs/arrow_gradient";
include "figs/AutoColors.asy.tmp";

real img_size = 200;
size(img_size);
srand(2);

// parameters
pen accent = primary;
pen accent2 = secondary;
pen accent3 = tertiary;
pen background = background_light;
pen line_pen = primary + dashed + linewidth(2);
pen parabola_pen = linewidth(2);

real range_x =2;
real num_lines = 7;


// draw a parabola graph 
real f(real x) {return x^2;}
pair F(real x) {return (x,f(x));}

real max_line = f(range_x)*0.9;


// draw horizontal lines that intersect with the parabola
for (int i=1; i<=num_lines; ++i){
	real y = max_line * i/num_lines;
	draw((-sqrt(y),y)--(sqrt(y),y), line_pen);
}

// draw the parabola
draw(graph(f,-range_x,range_x,operator ..), parabola_pen);







shipout(bbox(2mm, background, Fill));
