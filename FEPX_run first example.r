#Property of Not Real Engineering 
#Copyright 2021 Not Real Engineering - All Rights Reserved You may not use, 
#           distribute and modify this code without the written permission 
#           from Not Real Engineering.
############################################################################
##             FEPX example                                               ##
############################################################################

# Start Ubuntu app for windows
$ cd /mnt/c
$ cd FEPX_Example

# Step-1 Create microstructure 
$ neper -T -n 50 -reg 1 -morpho gg -o simulation
$ neper -V simulation.tess -datacellcol id -print Image_Polycrystal

# Step-2 Create mesh
$ neper -M simulation.tess -order 2 -part 4
$ neper -V simulation.tess,simulation.msh -dataelsetcol id -print Image_Mesh

# Step-3 Apply material properties, BC and simulate
# COPY "simulation.config" file to this folder
$ fepx

# Step-4 Postprocess raw results
$ neper -S .

# Step-5 Visualize the results
$ neper -V ../FEPX_Example.sim \
    -simstep 2 \
    -datanodecoo coo \
    -dataelt1drad 0.004 \
    -dataelt3dedgerad 0.0015 \
    -datanodecoofact 10 \
    -dataelt3dcol stress33 \
    -dataeltscaletitle "Stress 33 (MPa)" \
    -dataeltscale 0:850 \
    -showelt1d all \
    -cameraangle 13.5 \
    -imagesize 800:800 \
    -print 1_s33_deform
	
$neper -V ../FEPX_Example.sim \
    -simstep 2 \
    -datanodecoo coo \
    -dataelt1drad 0.004 \
    -dataelt3dedgerad 0.0015 \
    -datanodecoofact 10 \
    -dataelt3dcol strain-el33 \
    -dataeltscaletitle "Strain 33 (-)" \
    -dataeltscale 0.000:0.001:0.002:0.003:0.004 \
    -showelt1d all \
    -cameraangle 13.5 \
    -imagesize 800:800 \
    -print 1_e33_deform

# COPY "plot_stress_strain.gp" file to this folder
$ gnuplot plot_stress_strain.gp

	