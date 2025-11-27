settings.outformat = "png";
settings.render = 8; 
import math;
include "figs/AutoColors.asy.tmp";

size(300);

// Dimensions
real bodyW = 2.2;
real bodyH = 1.8;
real cornerR = 0.2;
real shackleRadius = 0.7;
real shackleThick = 0.25; 

real R_out = shackleRadius + shackleThick/2;
real R_in = shackleRadius - shackleThick/2;
real bodyTop = bodyH/2;
real shackleCenterY = 0.8;

// Define the Outer Boundary (Clockwise)
// Start at top-left of body where shackle meets, go around body, then go around shackle outer
path outer = 
    (-R_out, bodyTop) -- 
    (-bodyW/2 + cornerR, bodyTop) {left}..{down} (-bodyW/2, bodyTop - cornerR) -- 
    (-bodyW/2, -bodyH/2 + cornerR) {down}..{right} (-bodyW/2 + cornerR, -bodyH/2) -- 
    (bodyW/2 - cornerR, -bodyH/2) {right}..{up} (bodyW/2, -bodyH/2 + cornerR) -- 
    (bodyW/2, bodyTop - cornerR) {up}..{left} (bodyW/2 - cornerR, bodyTop) -- 
    (R_out, bodyTop) -- 
    (R_out, shackleCenterY) -- 
    arc((0, shackleCenterY), R_out, 0, 180) -- 
    (-R_out, shackleCenterY) -- 
    cycle;
// Note: The above path traces:
// 1. Top edge left part (from shackle to corner)
// 2. Left side
// 3. Bottom side
// 4. Right side
// 5. Top edge right part
// 6. Shackle right leg up
// 7. Shackle arc (CCW 0 to 180) -> Wait, 0 to 180 is Right to Left.
// 8. Shackle left leg down
// This is a Counter-Clockwise (CCW) loop overall?
// Let's check: 
// (R_out, 0.9) -> (1.1, 0.9) -> (1.1, -0.9) -> ... (-1.1, 0.9) -> (-R_out, 0.9) -> ...
// If I trace it:
// Start (-R_out, bodyTop). Move Left to (-bodyW/2...). 
// This is moving Negative X. 
// Then Down (-Y). Then Right (+X). Then Up (+Y). Then Left (-X) to (R_out...).
// Then Up (+Y). Arc 0->180 (Right to Left). Down (-Y).
// This loop is Counter-Clockwise.
// Standard fill works for single path.
// For holes, we need opposite direction or evenodd rule.

// Define Shackle Hole (Clockwise)
path shackleHole = 
    (R_in, bodyTop) -- 
    (R_in, shackleCenterY) -- 
    arc((0, shackleCenterY), R_in, 0, 180) -- 
    (-R_in, shackleCenterY) -- 
    (-R_in, bodyTop) -- 
    cycle;
// This traces:
// (0.575, 0.9) -> (0.575, 0.8) -> Arc to (-0.575, 0.8) -> (-0.575, 0.9) -> Close.
// This is CCW.
// To make it a hole in a CCW outer shape, it should be CW?
// Let's reverse it.
shackleHole = reverse(shackleHole);


// Define Keyhole (Clockwise)
real khR = 0.25;
pair khC = (0, 0.05);
pair p1 = khC + (khR * 0.6, -0.3); // Triangle bottom right relative to center
pair p2 = khC + (-khR * 0.6, -0.3); // Triangle bottom left relative to center
// Recalculate triangle vertices to match previous visual
// Previous: fill((0, -0.1) -- (khR*0.6, -0.7) -- (-khR*0.6, -0.7) -- cycle, black);
// Center (0, -0.1). p1 = (0.15, -0.7). p2 = (-0.15, -0.7).
pair p1_abs = (khR*0.6, -0.7);
pair p2_abs = (-khR*0.6, -0.7);

// We need intersection with circle centered at khC with radius khR.
// vector from khC to p1_abs: (0.15, -0.6).
// degrees = degrees((0.15, -0.6));
// We want the arc of the circle that forms the top of the keyhole.
// CCW from p1 direction to p2 direction? 
// p1 is right-ish (approx -76 deg). p2 is left-ish (approx -104 deg).
// We want the long arc: -76 -> 0 -> 90 -> 180 -> -104.
path keyhole = arc(khC, khR + 0.02, degrees(p1_abs-khC), degrees(p2_abs-khC)) -- p2_abs -- p1_abs -- cycle;
path keyhole_hole = circle(khC, khR);
// This is CCW.
// Reverse for hole.
// keyhole = reverse(keyhole) ^^ reverse(keyhole_hole);

path[] lockShape = outer ^^ shackleHole ^^ reverse(keyhole) ^^ reverse(keyhole_hole);

// Gradient
pen metal2 = primary; // Gold light
pen metal1 = secondary; // Gold dark
// Axial shade from top-left to bottom-right
axialshade(lockShape, metal1, (-bodyW/2, bodyH/2), metal2, (bodyW/2, -bodyH/2));

// Optional: Draw outline
// draw(lockShape, metal2 + linewidth(0.5));
