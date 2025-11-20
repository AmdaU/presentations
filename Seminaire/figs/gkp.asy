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
pen blue_temp = RGB(0, 83, 88);
pen blue = RGB(100,100,200);

pen current_red = RGB(215, 95, 87);
pen current_blue = blue_temp;



// main ----------------------------------------------------------------------
for (int i=-floor(grid_l / 2); i<=floor(grid_l / 2); ++i){	
 for (int j=-grid_l + 1; j<grid_l; ++j){
	 fill(circle((i * l, j * l/2), pt_s), current_red);
 }
}
//fill(circle((0.001, 0.001), pt_s), RGB(220,50,50));
if (state == 0) {

for (int i=-floor(grid_l / 2); i<=floor(grid_l / 2); i+=2){	
 for (int j=-grid_l + 1; j<grid_l; j+=2){
	 fill(circle((i * l, j * l/2), pt_s), current_blue);
 }
}

} else {
for (int i=-floor(grid_l / 2) -1; i<=floor(grid_l / 2); i+=2){	
 for (int j=-grid_l + 1; j<grid_l; j+=2){
	 fill(circle((i * l, j * l/2), pt_s), current_blue);
 }
}
}

// make envelope -------------------------------------------------------------

/* real rad = (grid_l+1) * l/sqrt(2);
unitsize(1cm);
int n = 100; // number of layers
for(int i=0; i<n; ++i) {
  real r = i/(n-1.0); // normalized radius
  real opa = exp(-delta_like/rad*r*r); // Gaussian function
  pen color = bg_color+opacity(1-opa)+linewidth((rad/(n-1) + 0.1015) *cm);
  draw(scale(r*rad)*unitcircle, color);
} */


// make text ----------------------------------------------------------------
if (draw_axis) {
	defaultpen(font_color);
	if (state == 0){
	for (int i=-floor(grid_l / 2);i<=floor(grid_l / 2); ++i){	
	label(string(i) + "$\sqrt{\pi}$", (- (floor(grid_l/2)+1)*l, i*l), fontsize(18pt));
	}
	}

	for (int i=-floor(grid_l / 2);i<=floor(grid_l / 2); ++i){	
	label(string(i) + "$\sqrt{\pi}$", (i*l, - (floor(grid_l/2)+0.5)*l), fontsize(18pt));
	}

}

//label ("$|" + string(state) + "\rangle$", (0, (grid_l+0.5)/2 * l), fontsize(20pt));

path boundary = box(((grid_l)*l, (grid_l+2)*l/2), (-(grid_l-1)*l,-(grid_l+1)*l/2)); // the boundary
clip(boundary);


