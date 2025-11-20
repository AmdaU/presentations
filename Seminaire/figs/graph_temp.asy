import settings;
// outformat = "pdf";
htmlviewer="/usr/bin/chromium-browser";
//import graph3 -----------------------------------------------------------------------------
import graph;
include "figs/AutoColors.asy.tmp";

real img_size = 500;
size(img_size);
srand(2);

// parameters
real bar_width = 30;
real spacing = 30;
real T_room = 300;
real hbarE_0sKb = 0.05;
real T_fridge = 0.01;
pen accent = mainblue;
pen accent2 = mainred;
pen accent3 = tertiary;
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
pen tick_pen = fontsize(fontsize)+linewidth(2);

real log_scale(real x){
	return 20*log(1000*x);
}

//bar 1
real y1 = log_scale(T_room);
pair pos1 = (spacing/2,0);
fill(box(pos1, pos1 + (bar_width, y1)), accent);
label("$T_{\rm piece}$", pos1 + (bar_width/2, 0), fontsize(fontsize), align=S);

//bar 2
real y2 = log_scale(hbarE_0sKb);
pair pos2 = pos1 + (bar_width + spacing, 0);
fill(box(pos2, pos2 + (bar_width, y2)), accent2);
label("$\frac{\hbar \omega_0}{k_B}$", pos2 + (bar_width/2, 0), fontsize(fontsize), align=S);

//bar 3
real y3 = log_scale(T_fridge);
pair pos3 = pos2 + (bar_width + spacing, 0);
fill(box(pos3, pos3 + (bar_width, y3)), accent3);
label("$T_{\rm ordi}$", pos3 + (bar_width/2, 0), fontsize(fontsize), align=S);


//draw y axis
draw((0,0)--(0,y1 * 1.1), main_axis_pen, Arrow(10));
// ticks label
ytick(string(T_room) + " K", y1, p=tick_pen);
ytick(string(hbarE_0sKb) + " K", y2, p=tick_pen);
ytick(string(T_fridge) + " K", y3, p=tick_pen);
labely(rotate(90)*"$T$ (K)", (0,y1 * 1.1)/2, fontsize(fontsize), align=W);


shipout(bbox(2mm, background, Fill));
