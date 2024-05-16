# --- End-to-end analysis

# Import Qfish data:
fish <- read.csv("C:/Users/ellen/OneDrive/Documents/JCU/2024/MB5370 Techniques 1/Module 4 - Data in R/charterfishery_catcheffort.csv")

# check data:
str(fish) # data is set up messily, need to fix

library(tidyverse) # install to access functions


  fish |>  
  pivot_longer(
    cols = starts_with("comb", "diving", "line", "net", "other", "pot"), 
    names_to = "fishing_method", 
    values_to = "rank"
  )

# add column called fishing method to put combined in it
combined <-
  fish |>
    select(starts_with("Comb")) |>
    add_column("Fishing_method" = "combined")

combined #check

# rename variable names:
names(combined)[1] <- "Licences"
names(combined)[2] <- "Days"
names(combined)[3] <- "Tonnes"
names(combined)[4] <- "DiscardNo"

# Remove first row that contained old headings
combined2 <- combined[-c(1), ]

names(combined) <- FALSE
combined
