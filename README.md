# Code for White Light Reduces Flight Height of Birds in Low-Density Migration Corridor analyses

This repository hosts the workflow used to carry out the spatial analysis for the study 'White Light Reduces Flight Height of Birds in Low-Density Migration Corridor'. 

Forward any questions regarding this project and code base to Mikko Jimenez (mjimenez@lpzoo.org)

## Description of scripts

**setup.R** - This script is used to load (and install, if necessary) packages used throughout the project. It is called at the beginning of all subsequent scripts. Expected run time <5 seconds. 

*#gam_onvsoff.RR** - This R script subsets a BirdScan MR1 dataset by light color and fits multiple generalized additive models, then uses the subsets to examine how different lighting treatments affect bird migration traffic rate, flight height, and flight direction while accounting for time after sunset, color, moonlight and cloud cover.

**gam_treatments.R** - This R script loads a BirdScan MR1 dataset with calculated differences (lighting treatments minus control) and fits generalized additive models to test how different lighting treastments influence changes in migration traffic rate, flight height, and flight direction while accounting for time after sunset, color, moonlight, and cloud cover.

*All scripts have been test in R Version 2025.05.1+513 (2025.05.1+513)

## Data availability
All data for these scripts can be found in the included Data folder. 
