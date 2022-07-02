#R script for GLMM model for OTU-Microbiome Datag

#Load the packages (only need to run this once)
packageVersion("glmmTMB")

#load the libraries
library(glmmTMB)
set.seed(1)
#Read in data
#/Users/klfrank/Dropbox/Bioinformatics/Projects/NewZealand_Analysis/NZL_Analysis_nosub/Outputs/metagenome.summer.longdata.csv
longdata<-read.csv("metagenome.summer.longdata.csv", head=TRUE)

#MOD1 = example with random intercept and slope:
model1 <- glmmTMB(Count~offset(log(sumreads))+
                    pH+(1+pH|OTU), 
                  family = nbinom2, 
                  data = longdata, control=glmmTMBControl(parallel = 19))

summary(model1)

#MOD2 =example with random intercept but testing the slope
model2 = glmmTMB(Count~offset(log(sumreads))+
                   pH+(1|OTU), 
                 family = nbinom2, 
                 data = longdata, control=glmmTMBControl(parallel = 19))

summary(model2)

anova(model1, model2)

ranf1 <- ranef(model1)
ranf1
cond <- ranf1$cond
write.csv(cond, "ranef_mod1_pH_cond-parallel.csv")

