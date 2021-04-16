library(tidyverse)
bc <- read_csv("before_covid_petition_jan_apr.csv")
b4 <- read_csv("data/before_covid_petition.csv")

b4 <- b4[b4$expiryDate>"2019-04-30",]
bc$id <- 363426:433858

beforeCovid <- bind_rows(b4,bc)

write.csv(beforeCovid,"before_covid_petition.csv",row.names = F)
