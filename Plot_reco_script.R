#----- Plot Reconstruction ------

library(readr)
library(tidyverse)


africa <- read.csv("C:/Users/ellen/OneDrive/Documents/JCU/2024/MB5370 Techniques 1/Module 4 - Data in R/Data for plot reco.csv")

p <- ggplot(data=africa) +
  geom_point(mapping = aes(x=Year, y=GDP_GR)) +
  geom_line(mapping = aes(x=Year, y=GDP_GR)) +
  facet_wrap(~Country, nrow=3) +
  theme_light() +
  theme(axis.text.x = element_text(angle=90, vjust=.5, hjust=1)) +
  xlab("Year") +
  ylab("GDP Growth Rate (%)")
p
p + theme(strip.background = element_rect(fill = "black"))

ggsave("Plot_reco_final.png", width = 5, height = 4, dpi=300, units = "in")

