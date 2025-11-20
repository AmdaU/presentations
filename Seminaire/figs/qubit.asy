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
real bar_width = 30;
real spacing = 30;
real T_room = 300;
real hbarE_0sKb = 0.05;
real T_fridge = 0.01;
pen accent = primary;
pen accent2 = secondary;
pen accent3 = tertiary;
pen background = background_light;
// very light grey
pen mix_pen(pen p1, pen p2, real ratio){
	return p1 * ratio + p2 * (1-ratio);
}

pen main_axis_pen = linewidth(img_size * 0.01);
pen secondary_axis_pen = linewidth(img_size * 0.005)+rgb(0.3,0.3,0.3);
pen transparent = nullpen;
real fontsize = 30;
pen state_pen = linewidth(5);
pen arrow_pen = linewidth(2);

real spacing = 10;
real width = 10;

// state |0>
pair pos0 = (0,0);
draw(pos0--pos0 + (width,0), state_pen + accent);
label("$|0\rangle$", pos0 + (width, 0), fontsize(fontsize), align=E);

// state |1>
pair pos1 = pos0 + (0, spacing);
draw(pos1--pos1 + (width,0), state_pen + accent2);
label("$|1\rangle$", pos1 + (width, 0), fontsize(fontsize), align=E);

// energy level
pair gap = (pos1 - pos0)*0.05;
pair offset = (width/2, 0);
gradientArrowLine(
  pos0 + gap + offset, pos1 - gap + offset,
  accent, accent2,
  n = 200,
  w = 1.2bp,
  arrowAtStart = true,
  arrowAtEnd   = true,
  arrowLenEnd   = 0.7,   // absolute length in your coordinate units
  arrowWidthEnd = 0.35
);

// draw((pos0 + gap + offset) --(pos1 - gap + offset), arrow_pen, Arrows(10));


label("$\hbar \omega_0$", (pos0 + pos1)/2 + offset, fontsize(fontsize), align=E);





shipout(bbox(2mm, background, Fill));
