import settings;
pdfviewer="zathura";
htmlviewer="google-chrome";
outformat="pdf";
display="display";
animate="animate";
gs="gs";

import graph;
/*import olympiad;*/
import geometry;

void perpMark(picture pic=currentpicture, 
       pair M, pair O, pair B, real size=5, 
       pen p=currentpen, filltype filltype = NoFill){
  perpendicularmark(pic, M,unit(unit(O-M)+unit(B-M)),size,p,filltype);
}
/*----------------------------------------*/
size(10cm);


/*plan -----------------------------------*/
path plan_inf = (-2,0)--(1,0);
path plan_sup = (-2,1)--(1,1);

/*cercle*/
path circ = circle((0,0.5), 0.5);

pair v0 = (-1,1.2);

real theta = angle(v0);

pair A = intersectionpoint(plan_sup, (0,0) --10*v0);
pair C = intersectionpoint(circ, (0,0) -- 10*v0);
pair v1 = C-(0,1);
pair B = intersectionpoint((0,1)--(0,1)+5*v1, plan_inf);

draw(circ);
draw(plan_sup);
draw(plan_inf);
draw((0,0) -- A);
draw((0,1) -- B);

markangle(n=1,radius=10,A,(0,0),B);
markangle(n=1,radius=-10,(0,1),A,C);
markangle(n=2,radius=-10,(0,1),B,(0,0));
markangle(n=2,radius=10,A,(0,1),B);

perpMark(C,(0,1),(0,0),gray(0.5));

path y = C -- (C.x,0);
draw(y,blue);
label("$1+z$",y,blue);

path y1 = C -- (C.x,1);
draw(y1,red);
label("$-z$",y1,red);

label("$r$",(0,0)--B, orange);
label("$r'$",(0,1)--A, orange);
draw((0,0)--B, orange);
draw((0,1)--A, orange);


label("$A$", A, align=v0);
label("$B$", B, align=v1);
label("$C$", C, align=(-1,0));
label("$D=(0,0)$", (0,1), align=-v1);
label("$E=(0,-1)$", (0,0), align=-v0);


