# This script plots the Wigner function of a cat code state using QuTiP

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import TwoSlopeNorm, LinearSegmentedColormap
import qutip as qt
import json
import os
# get the directory of the current file
dir_path = os.path.dirname(os.path.abspath(__file__))


 # import colors from the colors.json file
with open('colors.json', 'r') as f:
    colors = json.load(f)

# convert colors to rgb tuples
def hex_to_rgb(hex_color):
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i + 2], 16) / 255 for i in (0, 2, 4))

red = hex_to_rgb(colors['mainred'])
blue = hex_to_rgb(colors['mainblue'])
background = hex_to_rgb(colors['background_dark'])
white = np.array([1, 1, 1])

# load a .dat file representing a density matrix or state vector
def load_rho(name):
    filename = os.path.join(dir_path, name + '.dat')
    rho = np.genfromtxt(filename, delimiter=',', dtype=complex)
    return qt.Qobj(rho)

def save_rho(rho, name):
    filename = os.path.join(dir_path, name + '.dat')
    np.savetxt(filename, rho.data.to_array(), delimiter=',')

def plot_wigner(rho):
    # Phase-space grid
    xvec = np.linspace(-5, 5, 200)
    yvec = np.linspace(-5, 5, 200)
    W = qt.wigner(rho, xvec, yvec)

    # Build symmetric stops in RGB but keep white in the center
    # If you can, prefer LAB interpolation (see Option 3)
    colors = [
        (0.0, blue),
        (0.5, background),
        (1.0, red),
    ]
    cmap = LinearSegmentedColormap.from_list("brand_rwb", colors, N=256)


    # Ensure 0 maps to the center (white). Use symmetric limits around 0.
    v = np.max(np.abs(W))
    norm = TwoSlopeNorm(vmin=-v, vcenter=0.0, vmax=v)

    fig, ax = plt.subplots()
    fig.patch.set_facecolor('none')
    ax.set_facecolor('none')
    ax.set_rasterization_zorder(0)
    ax.contourf(W, levels=256, cmap=cmap, norm=norm, linewidths=0, zorder=-1)

    ax.set_axis_off()

    return fig, ax

import argparse
if __name__ == '__main__':
    #parse args
    parser = argparse.ArgumentParser(description='Plot the Wigner function of a density matrix or state vector')
    parser.add_argument('name', type=str, help='The name of the density matrix or state vector to plot')
    args = parser.parse_args()
    print(args.name)
    rho = load_rho(args.name)
    print(rho)
    plot_wigner(rho)
    # set aspect ratio to 1:1
    plt.gca().set_aspect('equal', adjustable='box')
    plt.savefig(os.path.join(dir_path, args.name + '_wigner.pdf'), transparent=True, dpi=600, bbox_inches='tight', pad_inches=0)
    print(f"Saved {os.path.join(dir_path, args.name + '_wigner.pdf')}")
