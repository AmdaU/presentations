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

usepackage("amssymb");
usepackage("amsmath");



size(10cm, 10cm);

unitsize(1cm);

real pt_s = 0.15;
int grid_l = 7; 
int state = 0;
real l = sqrt(pi);
real delta_like = 90*2;
pen font_color = RGB(0,0,0);
pen bg_color = RGB(223, 218, 209);
bool draw_axis = true;



picture old = currentpicture;
picture wigner_pic;
currentpicture = wigner_pic;

real l = sqrt(pi);

unitsize(1cm);

// main ----------------------------------------------------------------------
for (int i=-floor(grid_l / 2); i<=floor(grid_l / 2); ++i){	
 for (int j=-grid_l + 1; j<grid_l; ++j){
	 fill(circle((i * l, j * l/2), pt_s), secondary);
 }
}
//fill(circle((0.001, 0.001), pt_s), RGB(220,50,50));
if (state == 0) {

for (int i=-floor(grid_l / 2); i<=floor(grid_l / 2); i+=2){	
 for (int j=-grid_l+2; j<grid_l; j+=2){
	 fill(circle((i * l, j * l/2), pt_s), primary);
 }
}

} else {
for (int i=-floor(grid_l / 2) -1; i<=floor(grid_l / 2); i+=2){	
 for (int j=-grid_l + 1; j<grid_l; j+=2){
	 fill(circle((i * l, j * l/2), pt_s), secondary);
 }
}
}


// make text ----------------------------------------------------------------
//if (draw_axis) {
	//defaultpen(font_color);
	//if (state == 0){
	//for (int i=-floor(grid_l / 2);i<=floor(grid_l / 2); ++i){	
	//label(string(i) + "$\sqrt{\pi}$", (- (floor(grid_l/2)+1)*l, i*l), fontsize(18pt));
	//}
	//}

	//for (int i=-floor(grid_l / 2);i<=floor(grid_l / 2); ++i){	
	//label(string(i) + "$\sqrt{\pi}$", (i*l, - (floor(grid_l/2)+0.5)*l), fontsize(18pt));
	//}

//}


path boundary = box(((grid_l)*l, (grid_l+2)*l/2), (-(grid_l-1)*l,-(grid_l+1)*l/2)); // the boundary
clip(boundary);


// wavefunction ----------------------------------------------------------------

picture wavefunction_pic;
currentpicture = wavefunction_pic;


unitsize(1cm);
// wavefunction
int n = floor(grid_l/2/2);
real line_height = l;
pen state0_color = secondary;
pen state1_color = primary;
pen line_width = linewidth(2pt);
int fontsize = 18;

pen axis_pen = linewidth(1pt);

// draw the state 0 lines and ticks
for (int i = -n; i <= n; ++i){
	if (i != 0){
		draw((i*l*2, 0)-- (i*l*2, line_height), line_width + state0_color);
	}
}


label("$\dotsb$", (-(n+0.5)*2*l, line_height/2));
label("$\dotsb$", ((n+0.5)*2*l, line_height/2));


draw((0,0)--(0,line_height), line_width+state0_color, "$|\bar 0\rangle$");
draw((0,0)--(0,0), line_width+state1_color, "$|\bar 1\rangle$");
//xtick("0", 0);

for (int i=-floor(grid_l / 2);i<=floor(grid_l / 2); ++i){	
	string label_string = string(i);
	if (i == 0){
		label_string = "$0$";
	}
	else{
		label_string = string(i) + "$\sqrt{\pi}$";
	}
label(label_string, (i*l, -0.5), fontsize(fontsize));
}

xaxis(xmin=-(n+1)*2*l, xmax=(n+1)*2*l, p=axis_pen,  Arrows(5));
labelx("$\hat x$",S, fontsize(fontsize*2));
yaxis(Label("$\psi(x)$", fontsize(fontsize), align=E), XEquals(-grid_l*l/2), axis_pen, EndArrow(5), ymin=0, ymax=line_height*1.2, autorotate=false);




shipoutWithMargin(2mm);

// wavefunction p ----------------------------------------------------------------

picture wavefunction_pic_2;
currentpicture = wavefunction_pic_2;

line_height = line_height*1.2;

unitsize(1cm);
// wavefunction
int n = floor(grid_l/2);

pen axis_pen = linewidth(1pt);

// draw the state 0 lines and ticks
for (int i = -n; i <= n; ++i){
	if (i != 0){
		draw((0, i*l)-- (line_height, i*l), line_width + state0_color);
	}
}


label("$\vdots$", (line_height/2, (n+0.5)*l));
label("$\vdots$", (line_height/2, -(n+0.5)*l));


draw((0,0)--(line_height, 0), line_width+state0_color, "$|\bar 0\rangle$");
//xtick("0", 0);

for (int i=-floor(grid_l / 2);i<=floor(grid_l / 2); ++i){	
	string label_string = string(i);
	if (i == 0){
		label_string = "$0$";
	}
	else{
		label_string = string(i) + "$\sqrt{\pi}$";
	}
label(label_string, (-line_height, i*l), fontsize(fontsize), align=E);
}


yaxis(ymin=-((n+1/2)+0.75)*l, ymax=((n+1/2)+0.75)*l, p=axis_pen,  Arrows(5));
labely("$\hat p$",2*W, fontsize(fontsize*2));
xaxis(Label("$\psi(p)$", fontsize(fontsize), align=N), YEquals((grid_l+1/2)*l/2), axis_pen, EndArrow(5), xmin=0, xmax=line_height*1.2);




shipoutWithMargin(2mm);



// attach pictures ----------------------------------------------------------------
currentpicture = old;

attach(wigner_pic.fit(), (0,0));
attach(wavefunction_pic.fit(), (0,-line_height*1.2 - grid_l*l/2));
attach(wavefunction_pic_2.fit(), (-line_height*1.2 - (grid_l+1/2)*l/2, 0));
attach(legend(2, nullpen), (point(S).x - 3/2*l,truepoint(S).y*1.4));