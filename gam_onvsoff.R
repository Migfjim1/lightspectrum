# run setup script to install/load necessary packages
source("setup.R")

# read in radar dataframe
data_path<-"/Users/mikkojimenez/Desktop/lightspectrum/data"
bird <- readRDS(file.path(data_path, "allbirds_800.rds"))

# write function to subset data to specific colors with 
process_color <- function(color, bird_df) {
  bird_df$chunk <- as.numeric(as.character(bird_df$chunk))
  color_chunks <- bird_df %>%
    filter(color == !!color) %>%
    pull(chunk)
  color_df <- bird_df %>%
    filter((color == !!color & chunk %in% color_chunks) | chunk %in% color_chunks)
  color_df <- color_df %>%
    filter(!is.na(chunk))
  if(is.factor(color_df$color)) {
    color_df$color <- relevel(color_df$color, ref = "none")
  } else {
    color_df$color <- factor(color_df$color, levels = c("none", setdiff(unique(color_df$color), "none")))
  }
  color_df$chunk <- as.factor(color_df$chunk)
  return(color_df)
}

# Apply the function to create subsets
bird_white <- process_color("white", bird)
bird_blue <- process_color("blue", bird)
bird_red <- process_color("red", bird)
bird_orange <- process_color("orange", bird)


# fit gams - mtr
model_white_mtr = gam(mtr_log ~ s(timeAfterSunset,k=3) + color + moonlightModel + 
                     TCC + s(timeChunkDate, bs = "re"), data=bird_white)
model_blue_mtr = gam(mtr_log ~ s(timeAfterSunset,k=3) + color + moonlightModel + 
                       TCC + s(timeChunkDate, bs = "re"), data=bird_blue)
model_red_mtr = gam(mtr_log ~ s(timeAfterSunset,k=3) + color + moonlightModel + 
                      TCC + s(timeChunkDate, bs = "re"), data=bird_red)
model_orange_mtr = gam(mtr_log ~ s(timeAfterSunset,k=3) + color + moonlightModel + 
                         TCC + s(timeChunkDate, bs = "re"), data=bird_orange)

# fit gams - height
model_white_height = gam(height_mean ~ s(timeAfterSunset,k=8) + color + moonlightModel + 
                           TCC + s(timeChunkDate, bs = "re"), data=bird_white)
model_blue_height = gam(height_mean ~ s(timeAfterSunset,k=3) + color + moonlightModel + 
                          TCC + s(timeChunkDate, bs = "re"), data=bird_blue)
model_red_height = gam(height_mean ~ s(timeAfterSunset,k=3) + color + moonlightModel + 
                         TCC + s(timeChunkDate, bs = "re"), data=bird_red)
model_orange_height = gam(height_mean ~ s(timeAfterSunset,k=3) + color + moonlightModel + 
                            TCC + s(timeChunkDate, bs = "re"), data=bird_orange)

# fit gams - azimuth
model_white_azimuth = gam(azimuth_mean ~ s(timeAfterSunset,k=3) + color + moonlightModel + 
                            TCC + s(timeChunkDate, bs = "re"), data=bird_white)
model_blue_azimuth = gam(azimuth_mean ~ s(timeAfterSunset,k=3) + color + moonlightModel + 
                           TCC + s(timeChunkDate, bs = "re"), data=bird_blue)
model_red_azimuth = gam(azimuth_mean ~ s(timeAfterSunset,k=3) + color + moonlightModel + 
                          TCC + s(timeChunkDate, bs = "re"), data=bird_red)
model_orange_azimuth = gam(azimuth_mean ~ s(timeAfterSunset,k=3) + color + moonlightModel + 
                             TCC + s(timeChunkDate, bs = "re"), data=bird_orange)

# set moi to model interested in summarizing and inspecting
moi<-model_white_height 

# diag
par(mfrow = c(2, 2)) 
gam.check(moi)

# model summary and plot
summary(moi)
plot(moi)



