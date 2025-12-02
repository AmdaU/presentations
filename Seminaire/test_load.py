import numpy as np
import os

filename = 'figs/states/error_1_krauss.dat'
print(f"Loading {filename}...")
try:
    rho = np.genfromtxt(filename, delimiter=',', dtype=complex)
    print("Loaded shape:", rho.shape)
    print("Contains nan:", np.isnan(rho).any())
    if np.isnan(rho).any():
        print("Indices of nan:", np.argwhere(np.isnan(rho)))
        # Print the first nan occurrence and the corresponding text from file if possible
        # Re-read file as text to see what corresponds to nan
        with open(filename, 'r') as f:
            lines = f.readlines()
            rows, cols = np.where(np.isnan(rho))
            if len(rows) > 0:
                r, c = rows[0], cols[0]
                print(f"First NaN at row {r}, col {c}")
                line = lines[r].strip().split(',')
                print(f"Text at that position: '{line[c]}'")

except Exception as e:
    print(e)


