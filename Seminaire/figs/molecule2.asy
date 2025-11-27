settings.outformat = "png";
settings.render = 8; 
import graph3;
import math;
include "figs/AutoColors.asy.tmp";

size(400);
currentprojection = perspective(5,2,3);

currentlight.background = background_light;

// 1. Fully Matte (No shine at all)
material matteRed = material(diffusepen=secondary, specularpen=black);

// 2. Satin / Low Shine (A tiny bit of reflection, realistic for rubber/paper)
material satinBlue = material(diffusepen=primary, specularpen=gray(0.1));

// --- Define Colors using RGB ---
// rgb(r, g, b) where 0 is none and 1 is full
pen carbonColor = rgb(0.2, 0.2, 0.2); // Dark Grey
pen hydroColor  = rgb(0.9, 0.9, 0.9); // Almost White
pen bondColor   = rgb(0.7, 0.7, 0.7); // Light Grey

// --- Geometry Setup (Same as before) ---
real rC = 0.45;
real rH = 0.25;
real bondLen = 1.6;

triple[] H_positions = {
    bondLen * (1,1,1)/sqrt(3),
    bondLen * (-1,-1,1)/sqrt(3),
    bondLen * (-1,1,-1)/sqrt(3),
    bondLen * (1,-1,-1)/sqrt(3)
};

// --- Draw Scene ---

// 1. Draw Bonds
// We use 'linewidth' to make the lines thick enough to see
for (triple hPos : H_positions) {
    draw(O -- hPos, bondColor + linewidth(10));
}

// 2. Draw Carbon Atom
// Just pass the 'pen' directly to draw()
draw(scale3(rC) * unitsphere, matteRed, nolight);

// 3. Draw Hydrogen Atoms
for (triple hPos : H_positions) {
    draw(shift(hPos) * scale3(rH) * unitsphere, satinBlue, nolight);
}