# run setup script to install/load necessary packages
source("setup.R")

# read in radar change (control-lighting treatment) dataframe
data_path<-"/Users/mikkojimenez/Desktop/lightspectrum/data"
change_df <- readRDS(file.path(data_path, "allbirds_diff_800.rds"))

# change_df models
mod_gam_mtr <- gam(mtr_difference ~ s(timeAfterSunset, k=3) + color + moonlightModel + 
                     TCC + s(timeChunkDate, bs = "re"), data = change_df)

mod_gam_height = gam(height_mean_difference ~ s(timeAfterSunset,k=3) + color + moonlightModel +
                       TCC + s(timeChunkDate, bs = "re"), data=change_df)

mod_gam_azimuth = gam(azimuth_difference ~   s(timeAfterSunset,k=3) + color + moonlightModel +
                        TCC + s(timeChunkDate, bs = "re"), data=change_df)

# set moi to model interested in summarizing and inspecting
moi<-mod_gam_height

# diag
par(mfrow = c(2, 2)) 
gam.check(moi)

# model summary and plot
summary(moi)
plot(moi)
