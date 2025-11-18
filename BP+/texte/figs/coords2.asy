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
path plan = (-3,0)--(1.5,0);

/*cercle*/
path circ = circle((0,0), 1);

pair v0 = (-1,2);

real theta = angle(v0);

pair S = (0, -1);
pair N = (0,  1);

pair X = intersectionpoint(circ, S--10*v0);
pair A = intersectionpoint(plan, S--10*v0);
pair v1 = X-(0,1);
pair B = intersectionpoint(N -- N+5*v1, plan);

draw(circ);
/*draw(plan_sup);*/
draw(plan);
/*draw(plan_inf);*/
draw(S -- X);
draw(B -- N);
draw(S -- N, dashed);

/*draw((0,1) -- B);*/

markangle(n=1,radius=-10,X,S,N);
markangle(n=1,radius=-10,X,B,A);
markangle(n=2,radius=-5,(0,0),A,S);
markangle(n=2,radius=-5,B,A,X);

perpMark((0,0),S,A);
perpMark(X,A,B);


draw(A--S,StickIntervalMarker(1,2));
draw(A--X,StickIntervalMarker(1));
draw((0,0)--S,StickIntervalMarker(1,3));
draw(B--A,StickIntervalMarker(1,2));
draw((0,0)--A,StickIntervalMarker(1));
draw(B--X,StickIntervalMarker(1,3));

draw(A--(0,0),orange);
draw(B--(0,0),orange);
label("$r'$", A--(0,0), orange);
label("$r$", B--(0,0), orange);


label("$X$",X,align=(-0.5,0.5));
label("$A$",A,align=(-0.5,-0.5));
label("$B$",B,align=(-0.5,0.5));
label("$S$",S,align=(-0,-0.5));
label("$N$",N,align=(-0,0.5));
label("$O$",(0,0),align=(0.5,0.5));
/*path y = C -- (C.x,0);*/
/*draw(y,blue);*/
/*label("$1+z$",y,blue);*/

/*path y1 = C -- (C.x,1);*/
/*draw(y1,red);*/
/*label("$-z$",y1,red);*/

/*label("$r$",(0,0)--B, orange);*/
/*label("$r'$",(0,1)--A, orange);*/
/*draw((0,0)--B, orange);*/
/*draw((0,1)--A, orange);*/


/*label("$A$", A, align=v0);*/
/*label("$B$", B, align=v1);*/
/*label("$C$", C, align=(-1,0));*/
/*label("$D=(0,0)$", (0,1), align=-v1);*/
/*label("$E=(0,-1)$", (0,0), align=-v0);*/


