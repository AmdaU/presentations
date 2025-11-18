import settings;
outformat = "html";
htmlviewer="/usr/bin/chromium-browser";

import graph3;
//import solids;
import three;
size(200);
//darkmode barkground
//size3(200,IgnoreAspect);
//currentprojection=perspective(0,0,10,Y);
//currentprojection = perspective((0,0,100), (0,1,0), (20,0,-10));
currentprojection = perspective((70,0,100), (0,1,0), (0,0,-10));
srand(2);

// parameters
bool darkmode = true;
int num_graphs = 30;
real d_graph = 5;
real d_last_plane = 5;
int N = 50;
real noise_amp = 6;
real sin_amp = 10;
real depth = 10;
pen accent = RGB(215, 95, 87);
pen accent_dark = RGB(169, 48, 40);
pen accent2 = RGB(0, 83, 88);
pen accent2_dark = RGB(0, 157, 166);
real plane_opacity = 0.3;
// yellowish of white (not yellow)
pen plane_color = RGB(194, 200, 196);
// dark mode plane color
pen plane_color_dark = RGB(45, 47, 56);
pen curve_color = RGB(0,0,0);
pen curve_color_dark = RGB(255, 249, 229);


if (darkmode){
	currentlight.background = RGB(24, 24, 37);
	plane_color = plane_color_dark;
	curve_color = curve_color_dark;
	accent2 = accent2_dark;
} else {
	currentlight.background = RGB(223, 218, 209);
}

void fill(picture pic=currentpicture, path g,pen p=lightblue){
};

real tot_amp = sin_amp + noise_amp;

// Generate N equally spaced points between 0 and 2π
real[] z; // array to store the points
for (int i = 0; i < N; ++i) {
  z.push(2*pi*i/(N-1));
}


real[][] ys;

for (int i=0; i<num_graphs; ++i){
	//make sins with every point of the sinewave shifted randomly
	real[] y;
	for (int j=0; j<N; ++j){
		y.push(sin_amp*sin(z[j]) + noise_amp*unitrand());
	}
	ys.push(y);
}

for (int i=0; i<num_graphs; ++i){

	
	real[] y = ys[i];
	real[] x = 0*z + d_graph*i;
	triple A = (x[0],-tot_amp,0);
	triple B = (x[0],tot_amp,0);
	triple C = (x[0],tot_amp,-depth*2*pi);
	triple D = (x[0],-tot_amp,-depth*2*pi);
	//triple A = (0,0,0), B = (10,0,0), C = (10,10,0), D = (0,10,0);

	// Create a closed guide (polygon) from the points:
	guide3 poly = A--B--C--D--cycle;

	// Convert the guide into a surface:
	surface s = surface(poly);
	draw(poly, opacity(0.5) + accent2, nolight);
	draw(s, plane_color+opacity(plane_opacity), nolight);
	draw(graph(x,y,-z*depth), linewidth(0.4)+curve_color, nolight);

}

for (int i=0; i<9; ++i){
	triple p = ((i+0.5)*d_graph,0,-pi*depth);
	label('$\mathbf{+}$',p, accent+fontsize(8));
}


// sum all the graphs
real[] y = 0*z;
for (int i=0; i<num_graphs; ++i){
	y = y + ys[i]/num_graphs;
}
real last_x = d_graph*(num_graphs+5);
draw(graph(last_x+z*0,y,-depth*z), curve_color);

//draw the plane
triple A = (last_x,-tot_amp,0);
triple B = (last_x,tot_amp,0);
triple C = (last_x,tot_amp,-depth*2*pi);
triple D = (last_x,-tot_amp,-depth*2*pi);
//triple A = (0,0,0), B = (10,0,0), C = (10,10,0), D = (0,10,0);

// Create a closed guide (polygon) from the points:
guide3 poly = A--B--C--D--cycle;

// Convert the guide into a surface:
surface s = surface(poly);
draw(s, plane_color+opacity(plane_opacity), nolight);
draw(poly, opacity(0.5) + accent2, nolight);




//draw arrow
real margin = 5;
triple start = (d_graph*(num_graphs-1) + margin,0,-pi*depth);
triple end = (last_x-margin*1.5,0,-pi*depth);

draw(start--end, accent, Arrow3(7));


real last_x = d_graph*(num_graphs+25);
//draw(graph(last_x+z*0,y,-depth*z), opacity(0));

