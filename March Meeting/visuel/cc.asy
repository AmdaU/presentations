import settings;
outformat = "svg";
htmlviewer="/usr/bin/google-chrome-stable";

import graph3;
import solids;
import three;
size(200);
currentprojection=perspective(1/3,-1,0.6);

real R=0.1;
surface atom = scale3(R)*unitsphere;

void g(triple center, triple face, triple sh) {

    draw(shift(center + (1, 1, 1)/2) * atom, red);

      for (int i=0; i<2; ++i){
        for (int j=0; j<2; ++j){
            for (int k=0; k<2; ++k){
                draw(shift(center + (i, j, k)) * atom, red);
                
                
                int ii = (i + 1)  % 2;
                int jj = (j  + 1) % 2;
                int kk = (k  + 1) % 2;

                draw((i, j, k)+center -- (ii, j, k)+center, linewidth(0.5)+black);
                draw((i, j, k)+center -- (i, jj, k)+center, linewidth(0.5)+black);
                draw((i, j, k)+center -- (i, j, kk)+center, linewidth(0.5)+black);

                pen bg=red+opacity(0.05);
                
                triple h = ((face.x + 1)%2, (face.y + 1)%2, (face.z + 1)%2);
                triple m1 = (h.x * h.y, h.y * h.z, h.z * h.x);
                triple m2 = (h.z * h.x, h.x * h.y, h.y * h.z);

                path3 shaded_face = shift(sh) * ((0, 0, 0)--m1--h--m2--cycle);
                draw(surface(shift(center) * shaded_face), bg);
            }
        }  
    }

}

g((1, 0, 0), (0, 0, 1), (0, 0, 1));
g((0, 0, 1), (1, 0, 0), (1, 0, 0));
g((1, 1, 1), (0, 1, 0), (0, 0, 0));

triple center = (1, 1, 1);
triple A = center + ( 1, -1, -1)/2;// 1/2 1/2 1/2
triple B = center + (1,  1, 1)/2; // -1/2 1/2 1/2
triple C = center + (-1, -1,  1)/2;

triple dA = A-center;
triple dB = B-center;
triple dC = C-center;



draw(center -- A, linewidth(1) + orange);
draw(center -- B, linewidth(1) + orange);
draw(center -- C, linewidth(1) + orange);

label('$A$', A, align=N+3*E);
label('$B$', B, align=3*N);
label('$C$', C, align=3*N);

label('$O$', center, align=3*E);

draw(C -- C-(0,0,1), green+linewidth(2));
draw(C -- C+(0,1,0), green+linewidth(2));

draw(A -- A-(1,0,0), green+linewidth(2));
draw(A -- A-(0,-1,0), green+linewidth(2));

draw(B -- B-(0,0,1), green+linewidth(2));
draw(B -- B-(1,0,0), green+linewidth(2));

draw(B--C, blue+linewidth(2));
draw(A--C, blue+linewidth(2));
draw(B--A, blue+linewidth(2));





// angle

// guide3 alphaArc=arc(center, center+0.25*dC, center+0.25*dA);
// draw(alphaArc, black);

// guide3 alphaArc=arc(center, center+0.25*dA, center+0.25*dB);
// draw(alphaArc, black);


triple off = (-1, 0, 0);

draw(center+off --B+off, linewidth(2.5) + purple);
draw(center+off --C+off, linewidth(2.5) + purple);
draw(center+off --A+off, linewidth(2.5) + purple);
draw(B+off -- B+dC+off, linewidth(2.5) + purple);
draw(B+off -- B+dA+off, linewidth(2.5) + purple);
draw(C+off -- C+dB+off, linewidth(2.5) + purple);
draw(C+off -- C+dA+off, linewidth(2.5) + purple);
draw(A+off -- A+dC+off, linewidth(2.5) + purple);
draw(A+off -- A+dB+off, linewidth(2.5) + purple);
draw(B+dC+off -- B+dC+dA+off, linewidth(2.5) + purple);
draw(B+dA+off -- B+dC+dA+off, linewidth(2.5) + purple);
draw(C+dA+off -- C+dA+dB+off, linewidth(2.5) + purple);
