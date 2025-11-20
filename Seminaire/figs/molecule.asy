import settings;
// outformat = "pdf";
htmlviewer="/usr/bin/chromium-browser";
//import graph3 -----------------------------------------------------------------------------
import graph;
include "figs/AutoColors.asy.tmp";

real img_size = 2000;
size(img_size);
srand(2);

// parameters
bool darkmode = false;
int num_graphs = 50;
int N = 30;
real r = 0.015;
pen accent = mainblue;
pen accent2 = mainred;
pen background = background_light;
// very light grey
pen mix_pen(pen p1, pen p2, real ratio){
	return p1 * ratio + p2 * (1-ratio);
}

pen arc_pen = linewidth(img_size * 0.01);
pen axis_pen = linewidth(img_size * 0.01);
pen box_pen = linewidth(img_size * 0.005);
pen transparent = nullpen;
real fontsize = 30;

//draw background


pair[] atom_positions = new pair[N];


for (int i=0; i<N; ++i){
	atom_positions[i] = rotate(unitrand()*360)*(0, unitrand());
}

// function to get the color of the dot based on the position



for (int i=0; i<N; ++i){
	for (int j=i+1; j<N; ++j){
		if (exp(sqrt(length(atom_positions[i] - atom_positions[j]))) < 2*unitrand() && abs(atom_positions[i].y - atom_positions[j].y) < 100*unitrand()){
			draw(atom_positions[i]--atom_positions[j], arc_pen);
		}
	}
}

int n_inside = 0;
int n_outside = 0;
pen get_color(pair p){

	if (p.x^2 + p.y^2 < 1){
		++n_inside;
		return accent;
	} else {
		++n_outside;
		return accent2;
	}
}


for (int i=0; i<N; ++i){
	fill(circle(atom_positions[i], r), get_color(atom_positions[i]));
}


// label("$\pi$ = " + string(4 * n_inside / (n_inside + n_outside)), (0.5,0.5));
shipout(bbox(2mm, background, Fill));
