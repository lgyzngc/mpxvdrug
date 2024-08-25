#!/bin/bash

# Author: Bruce Zhou
# Date: 2024-04-03

# loop through each pdbqt file in the pdbqtLigands directory
for file in ../pdbqtLigands/*.pdbqt

do 
  baseName=$(basename $file) # get the base name of the file
  if [ ! -f "${baseName%.pdbqt}.log" ]; then
    ./vina_1.2.5 --config config.txt --ligand $file --out output.pdbqt > ${baseName%.pdbqt}.log # run vina with the config file and the ligand file
  fi
done

# collect the results
mkdir bioactiveResults
mv EBC*.log bioactiveResults/

# run molecular docking on the control ligands
for file in ../controls/*.pdbqt

do 
  baseName=$(basename $file)
  if [ ! -f "${baseName%.pdbqt}.log" ]; then
    ./vina_1.2.5 --config config.txt --ligand $file --out output.pdbqt > ${baseName%.pdbqt}.log
  fi
done

# extract the results
./extract_energy.sh > ranked_energy.log

tar -czvf results.tar.gz ranked_energy.log brincidofovir.log tecovirimat.log cidofovir.log
