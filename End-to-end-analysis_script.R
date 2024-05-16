# --- End-to-end analysis

# Import Qfish data:
fish <- read.csv("C:/Users/ellen/OneDrive/Documents/JCU/2024/MB5370 Techniques 1/Module 4 - Data in R/charterfishery_catcheffort.csv")

# check data:
str(fish) # data is set up messily, need to fix

library(tidyverse) # install to access functions

# ---- COMBINED DATAFRAME

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


# Remove first row that contained old headings:
combined <- combined[-c(1), ]

# Add Column with years 1992-2023:
combined$new_var <- c(1992:2023)
# change name to Years
names(combined) [6] <- "Year"

# Move 'year' column to start:
combined <- combined %>% relocate(Year)

# ---- DIVING DATAFRAME
# add column called fishing method to put combined in it
diving <-
  fish |>
  select(starts_with("Div")) |>
  add_column("Fishing_method" = "diving")

diving #check

# rename variable names:
names(diving)[1] <- "Licences"
names(diving)[2] <- "Days"
names(diving)[3] <- "Tonnes"
names(diving)[4] <- "DiscardNo"


# Remove first row that contained old headings:
diving <- diving[-c(1), ]

# Add Column with years 1992-2023:
diving$new_var <- c(1992:2023)
# change name to Years
names(diving) [6] <- "Year"

# Move 'year' column to start:
diving <- diving %>% relocate(Year)



# ---- LINE DATAFRAME
# add column called fishing method to put combined in it
line <-
  fish |>
  select(starts_with("Lin")) |>
  add_column("Fishing_method" = "line")

line #check

# rename variable names:
names(line)[1] <- "Licences"
names(line)[2] <- "Days"
names(line)[3] <- "Tonnes"
names(line)[4] <- "DiscardNo"


# Remove first row that contained old headings:
line <- line[-c(1), ]

# Add Column with years 1992-2023:
line$new_var <- c(1992:2023)
# change name to Years
names(line) [6] <- "Year"

# Move 'year' column to start:
line <- line %>% relocate(Year)



# ---- NET DATAFRAME
# add column called fishing method to put combined in it
net <-
  fish |>
  select(starts_with("Net")) |>
  add_column("Fishing_method" = "net")

net #check

# rename variable names:
names(net)[1] <- "Licences"
names(net)[2] <- "Days"
names(net)[3] <- "Tonnes"
names(net)[4] <- "DiscardNo"


# Remove first row that contained old headings:
net <- net[-c(1), ]

# Add Column with years 1992-2023:
net$new_var <- c(1992:2023)
# change name to Years
names(net) [6] <- "Year"

# Move 'year' column to start:
net <- net %>% relocate(Year)



# ---- OTHER DATAFRAME
# add column called fishing method to put combined in it
other <-
  fish |>
  select(starts_with("Other")) |>
  add_column("Fishing_method" = "other")

other #check

# rename variable names:
names(other)[1] <- "Licences"
names(other)[2] <- "Days"
names(other)[3] <- "Tonnes"
names(other)[4] <- "DiscardNo"


# Remove first row that contained old headings:
other <- other[-c(1), ]

# Add Column with years 1992-2023:
other$new_var <- c(1992:2023)
# change name to Years
names(other) [6] <- "Year"

# Move 'year' column to start:
other <- other %>% relocate(Year)




# ---- POT DATAFRAME
# add column called fishing method to put combined in it
pot <-
  fish |>
  select(starts_with("Pot")) |>
  add_column("Fishing_method" = "pot")

pot #check

# rename variable names:
names(pot)[1] <- "Licences"
names(pot)[2] <- "Days"
names(pot)[3] <- "Tonnes"
names(pot)[4] <- "DiscardNo"


# Remove first row that contained old headings:
pot <- pot[-c(1), ]

# Add Column with years 1992-2023:
pot$new_var <- c(1992:2023)
# change name to Years
names(pot) [6] <- "Year"

# Move 'year' column to start:
pot <- pot %>% relocate(Year)

# --- BIND ALL DATASETS
all <- bind_rows(combined, diving, line, net, pot, other)



# --- REMOVE BLANK CELLS & NAS
