library(tidyverse) # data formatting and graphing tools


# 2.0. Wrangling Data 
setwd("~/Desktop/TEXTBOOKS & RESOURCES - PhD/FALL 2025/INSTRUMENTATION/PhysTher5110")
list.files()
list.files("./data/")

DATA <- read.csv("./data/MASTER_EO_and_EC_EEG.csv",
                    header=TRUE, 
                    stringsAsFactors = TRUE)


# selecting specific columns
head(DATA)
DATA %>% select(subID, condition, Hz, Fz)
select(.data=DATA, subID, condition, Hz, Fz)

DATA %>% select(:F3)

DATA %>% select(-X)

DAT2 <- DATA %>% select(-X, -file_id)
head(DAT2)

# filtering specific rows
head(DAT2)
?dplyr::filter
DAT3 <- DAT2 %>% filter(subID=="oa02")
DAT3 <- DAT2 %>% filter(Hz<=5)

DAT3 <- DAT2 %>% filter(subID=="oa02" | subID=="oa03")
DAT3 <- DAT2 %>% filter(Hz<=5) 

DAT3 <- DAT2 %>% filter(subID=="oa01" & Hz==0.997)
DAT3

summary(unique(DAT2$Hz))
hist(unique(DAT2$Hz))

DAT3 <- DAT2 %>% filter(Hz<=5)
summary(unique(DAT3$Hz))
hist(unique(DAT3$Hz))


# computing new variables
head(DAT3)
F3 <- DAT3$F3
F7 <- DAT3$F7
Fz <- DAT3$Fz
F4 <- DAT3$F4
F8 <- DAT3$F8

C3 <- DAT3$C3
Cz <- DAT3$Cz
C4 <- DAT3$C4

P3 <- DAT3$P3
P7 <- DAT3$P7
Pz <- DAT3$Pz
P4 <- DAT3$P4
P8 <- DAT3$P8
O1 <- DAT3$O1
Oz <- DAT3$Oz
O2 <- DAT3$O2

DAT3$Frontal <- (DAT3$F3 + DAT3$F7 + DAT3$Fz + DAT3$F4 + DAT3$F8)/5)



?dplyr::mutate()
?dplyr::transmute()

?dplyr::rowwise
DAT3 <- DAT3 %>% rowwise() %>%
  mutate(frontal = mean(c(F3, F7, Fz, F4, F8), na.rm=TRUE),
         central = mean(c(C3, Cz, C4), na.rm=TRUE),
         parietal = mean(c(P3, P7, Pz, P4, P8), na.rm=TRUE),
         occipital = mean(c(O1, Oz, O2), na.rm=TRUE)
  )

(DAT3$F3 + DAT3$F7 + DAT3$Fz + DAT3$F4 + DAT3$F8)/5

head(DAT3)
plot(DAT3$Frontal, DAT3$frontal)
cor(DAT3$Frontal, DAT3$frontal, use = "complete.obs")



# Selecting only the columns we want
head(DAT3)
DAT4 <- DAT3 %>% select(subID, condition, Hz,
                        frontal, central, parietal, occipital) %>%
  mutate(ln_Hz = log(Hz),
         ln_frontal = log(frontal),
         ln_central = log(central),
         ln_parietal = log(parietal),
         ln_occipital = log(occipital))

head(DAT4)

Dat4filt <- DAT4[DAT4$Hz <=30, ]


setwd("~/Desktop/TEXTBOOKS & RESOURCES - PhD/FALL 2025/INSTRUMENTATION/PhysTher5110/data")
write.csv(DAT4, "data_PROCESSED_EEG.csv")

plot(Dat4filt$frontal, Dat4filt$ln_frontal) 
plot(Dat4filt$central, Dat4filt$ln_central)
plot(Dat4filt$parietal, Dat4filt$ln_parietal)
plot(Dat4filt$occipital, Dat4filt$ln_occipital)

