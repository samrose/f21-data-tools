## Instructions

install nix

install pypi2nix



1. run `pypi2nix -r requirements.txt` to update any requirements from the requirements.txt file

2. run `nix-shell requirements.nix -A interpreter`

3. If desired, run `nix-shell -p python3Packages.ipython -p python3Packages.pandas` to incorporate ipython and pandas from nixpkgs
