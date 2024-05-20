# --- End-to-end analysis

# Import Qfish data:
fish <- read.csv("data/charterfishery_catcheffort.csv")|>
  rename(Year = X)
fish
# check data:
str(fish) # data is set up messily, need to fix

library(tidyverse) # install to access functions
library(dplyr)

# ---- COMBINED DATAFRAME
combined <-
  fish |>
    select(Year, starts_with("Comb")) |> #
    add_column("Fishing_method" = "combined") |>
  rename(Licences = Combination,
         Days = Combination.1,
         Tonnes = Combination.2,
         DiscardNumber = Combination.3) |>
    slice(-1)

combined #check


# ---- DIVING DATAFRAME
diving <-
  fish |>
  select(Year, starts_with("Div")) |> #
  add_column("Fishing_method" = "diving") |>
  rename(Licences = Diving,
         Days = Diving.1,
         Tonnes = Diving.2,
         DiscardNumber = Diving.3) |>
  slice(-1)
diving


# ---- LINE DATAFRAME
line <-
  fish |>
  select(Year, starts_with("Lin")) |> #
  add_column("Fishing_method" = "line") |>
  rename(Licences = Line,
         Days = Line.1,
         Tonnes = Line.2,
         DiscardNumber = Line.3) |>
  slice(-1)
line

# Hardly any data on net, pot and other if not any, so not using that in analysis.


# --- BIND ALL DATASETS - except for net, pot and other as they have NAs only or metrics that I am not measuring (i.e., in other).
all <- bind_rows(combined, diving, line) |>
  as.tibble()



# --- REMOVE BLANK CELLS & NAS

# Replace all N/As as a blank:
all <- data.frame(lapply(all, function(x) {
  str_replace_all(x, "N/A", "")
}))


# Change Licences, Days, Tonnes and Discard No to numeric data types:
all <- 
  all |> 
  mutate(across(!c(Year, Fishing_method), as.numeric))


# Remove all NAs:
all <-  na.omit(all)
str_re

str(all) # check data type. Most are in character. Need to change.
DiscardNo
DiscardNo <- as.numeric(all$DiscardNo)

ggplot(data=all) +
  geom_point(mapping = aes(x=Year, y=DiscardNo))

ggplot(data= subset(all, !is.na(DiscardNo)), aes(x = Year, y = DiscardNo)) +
  geom_smooth()

#EXAMPLE BELOW:
library(ggplot2)
data("iris")
iris$Sepal.Length[5:10] <- NA  # Create some NAs for this example
ggplot(data = subset(iris, !is.na(Sepal.Length)), aes(x = Sepal.Length)) +
  geom_bar(stat = "bin")
