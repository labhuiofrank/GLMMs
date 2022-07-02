#R script for GLMM model for OTU-Microbiome Datag

#Load the packages (only need to run this once)
#install.packages("glmmTMB")

#load the libraries
library(glmmTMB)


#Read in data
#/Users/klfrank/Dropbox/Bioinformatics/Projects/NewZealand_Analysis/NZL_Analysis_nosub/Outputs/metagenome.summer.longdata.csv
longdata<-read.csv("metagenome.summer.longdata.csv", head=TRUE)

#longdata <- longdata1[sample(1:nrow(longdata1), 500,replace=FALSE),]

#MOD1 = example with random intercept and slope:
model1 <- glmmTMB(Count~offset(log(sumreads))+
                    pH+(1+pH|OTU), 
                  family = nbinom2, 
                  data = longdata,
                  ziformula=~(1|OTU))

summary(model1)

#MOD2 =example with random intercept but testing the slope
model2 = glmmTMB(Count~offset(log(sumreads))+
                   pH+(1|OTU), 
                 family = nbinom2, 
                 data = longdata,
                 ziformula=~(1|OTU))

summary(model2)

anova(model1, model2)

ranf1 <- ranef(model1)
write.csv(ranf1, "ranef_mod1.csv")
