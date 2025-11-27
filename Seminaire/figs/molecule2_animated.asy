settings.outformat = "gif";
settings.render = 8; 
import graph3;
import math;
import animation;
include "figs/AutoColors.asy.tmp";

size(400);
currentprojection = perspective(5,2,3);

currentlight.background = background_light;

// 1. Fully Matte (No shine at all)
material matteRed = material(diffusepen=secondary, specularpen=black);

// 2. Satin / Low Shine (A tiny bit of reflection, realistic for rubber/paper)
material satinBlue = material(diffusepen=primary, specularpen=gray(0.1));

// --- Define Colors using RGB ---
pen carbonColor = rgb(0.2, 0.2, 0.2); // Dark Grey
pen hydroColor  = rgb(0.9, 0.9, 0.9); // Almost White
pen bondColor   = rgb(0.7, 0.7, 0.7); // Light Grey

// --- Geometry Setup ---
real rC = 0.45;
real rH = 0.25;
real bondLen = 1.6;

triple[] H_positions = {
    bondLen * (1,1,1)/sqrt(3),
    bondLen * (-1,-1,1)/sqrt(3),
    bondLen * (-1,1,-1)/sqrt(3),
    bondLen * (1,-1,-1)/sqrt(3)
};

// --- Animation Setup ---
animation A;
int n_frames = 30; // 30 frames for one loop

for (int i = 0; i < n_frames; ++i) {
    save();
    
    // Time parameter t from 0 to 2*pi
    real t = i * 2 * pi / n_frames;

    // 1. Draw Carbon Atom (Center)
    // We keep the carbon static or give it a tiny counter-wiggle if desired.
    // For simplicity, we keep it static here.
    draw(scale3(rC) * unitsphere, matteRed, nolight);

    // 2. Draw Hydrogens and Bonds with Wiggle
    for (int j = 0; j < H_positions.length; ++j) {
        triple hPos = H_positions[j];
        
        // Create a "breathing" vibration along the bond
        // Different phase for each atom so it looks organic
        real phase = j * (pi / 2); 
        real wiggle = 0.05 * sin(t + phase); // 5% variation in bond length
        
        triple currentPos = hPos * (1 + wiggle);

        // Draw Bond to wiggled position
        draw(O -- currentPos, bondColor + linewidth(10));

        // Draw Hydrogen Atom at wiggled position
        draw(shift(currentPos) * scale3(rH) * unitsphere, satinBlue, nolight);
    }
    
    A.add();
    restore();
}

// Create the animation (loops=0 means infinite loop)
A.movie(loops=0, delay=50);

