# Antiviral Drug Repurposing for Monkeypox Virus With Genomic Evolution

Collaborators: Lige Zhang (DKU '26), Bruce Zhou (DKU '24), Prof. Gaoyang Li, Prof. Huansheng Cao.

# Molecular Docking

All scripts and configuration files can be found in the `docking/` folder.

## Screening Library

The screening library was obtained from Enamine Bioactive Compounds Collection, which consists of annotated compounds and FDA-approved drugs. It can be accessed at: https://enamine.net/compound-libraries/bioactive-libraries.

## Ligand Preparation

The screening library was originally prepared in 2D SDF format. We used the Open Babel 3.0.1 on Linux to generate the 3D coordinates for each compound. The quality was set to "slowest", which performs "Force field cleanup (500 cycles) + Slow rotor search".

## AutoDock Preparation

We prepared the PDBQT files needed for docking with AutoDock Vina using the [Meeko package](https://github.com/forlilab/Meeko/tree/release). Specifically, we used the `mk_prepare_ligand.py` script to turn 3D SDF files into the PDBQT files needed for docking.

The receptors were prepared using the AutoDockTools GUI following the standard workflow. A sample configuration files required for AutoDock Vina was uploaded as `config.txt`.

## Docking and Results Collecting

The PDBQT files are stored in the folder `pdbqtLigands`. The `vina_docking.sh` script will perform docking using AutoDock Vina and automatially collects results using the `extract_energy.sh` script.

## Docking

A blind docking strategy was adopted. For each receptor, the docking grid size was determined manually to make sure that the search covers the whole protein.

The maximum number of binding modes to generate was set to 50, and the exhaustiveness was set to 16 to increase search coverage.

# Molecular Dynamics

## Software

The GROMACS 2023.1 version was used to perform the molecular dynamics simulations.

## Force Field

The CHARMM36 all-atom force field (July 2022 version) was utilized, chosen for its optimization in protein-ligand interactions.

## Initial Setup

- **Protein Topology**: Generated using GROMACS's built-in commands.
- **Ligand Topology**: Created via the CGenFF server.
- **Simulation Environment**: Protein-ligand complexes were embedded in dodecahedral unit cells and solvated using the SPC216 solvent model.
- **System Neutralization**: Sodium or chloride ions were added to neutralize the system.

## Energy Minimization

- Conducted to ensure system stability before simulations.

## Equilibration

- Two stages:
  1. **NVT (constant Number of particles, Volume, and Temperature)** at 300K for 100 ps.
  2. **NPT (constant Number of particles, Pressure, and Temperature)** at 300K for 100 ps.

## Simulations

- Duration: 100 ns.
- Step Size: 2 ps.
- Total Steps: 50,000,000.

## Metrics

- Stability of protein-ligand complexes was evaluated using RMSD (root-mean-squared deviation) to confirm consistent fluctuations and equilibrium over the 100 ns period.