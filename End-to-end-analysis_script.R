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

# Also create dataframe without line on top of that too - too many high variables:
all2 <- bind_rows(combined, diving) |>
  as.tibble()

# --- REMOVE BLANK CELLS & NAS

# Replace all N/As as a blank:
all <- data.frame(lapply(all, function(x) {
  str_replace_all(x, "N/A", "")
}))

all2 <- data.frame(lapply(all2, function(x) {
  str_replace_all(x, "N/A", "")
}))

# Change Licences, Days, Tonnes and Discard No to numeric data types:
all <- 
  all |> 
  mutate(across(!c(Year, Fishing_method), as.numeric))

all2 <- 
  all2 |> 
  mutate(across(!c(Year, Fishing_method), as.numeric))


# Remove all NAs:
all <-  na.omit(all)
all2 <-  na.omit(all2)


### CREATE GGPLOT:

# Tonnage per year
plot1 <- ggplot(data=all2, mapping = aes(x=Year, y=Tonnes, fill = Fishing_method)) +
  geom_col() +
  theme_classic() +
  theme(axis.text.x = element_text(angle=90, vjust=.5, hjust=1)) +
  scale_fill_manual(values = c(combined = "#4F94CD", diving = "#43CD80")) +
  guides(fill = guide_legend("Fishing Method"))
plot1 + theme(legend.position = "bottom")

ggsave("Tonnage_per_year.png", width = 5, height = 4, dpi=300, units = "in")

# Effects of the no. of days on Tonnage
plot2 <- ggplot(data=all2, mapping = aes(x=Days, y=Tonnes, colour=Fishing_method)) +
  geom_point() +
  geom_smooth() +
  theme_classic() +
  scale_x_continuous(breaks = seq(50, 300, by = 50)) +
  scale_colour_manual(values = c(combined = "#00C5CD", diving = "#CD3278")) +
  guides(colour=guide_legend("Fishing Method"))
plot2 + theme(legend.position = "bottom")

ggsave("Days_on_tonnes.png", width = 5, height = 4, dpi=300, units = "in")
