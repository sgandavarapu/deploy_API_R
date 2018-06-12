#install.packages( "Rcpp", type = "source" )
#install.packages( "dplyr" )
#install.packages( "rjson" )
#install.packages( "rpart" )
#install.packages( "jsonlite" )
#install.packages( "caret" )
#install.packages("googleAuthR")         ## authentication             
#install.packages("googleCloudStorageR") 
#install.packages("remotes") 

library(googleAuthR)
library(googleCloudStorageR) 
options(googleAuthR.scopes.selected = "https://www.googleapis.com/auth/cloud-platform")
##### For LOCAL TESTING, change path to local folder
gar_auth_service("/payload/keyfile.json")
#gar_auth_service("/Users/sxg0748/Documents/workspace/deploy_API_R/keyfile.json")
#####

library(googleAuthR)
library(googleCloudStorageR) 
library(dplyr)
library(rjson)
library(rpart)
library(jsonlite)
library(caret)

gcs_global_bucket("ingo-risk-ml.appspot.com")
gcs_get_object("APItestmodel.Rdata", saveToDisk = "APItestmodel.Rdata", overwrite = TRUE)
model <- readRDS("APItestmodel.Rdata")

#* @post /predict
predict_autodecline<-function(DollarSize,ProductId,MakerClearedCheckCount,PayeeUnclearedAmountInstantOnly
                              ,LyonsCode,Counts_MOW,Counts_OnlyPreviouslyDeclinedHistory
                              ,MakerUnClearedCheckCount,TellerSuspicion,Counts_MOH
                              ,PayeeMakerUnClearedCombinedCheckCount,Customer_Freq_144,MakerNewCustomerFreq_NT,checknumber,Hour,Count_DNCDeclines_90days,CustomerState,latlonbadges,Ageattimeoftrans)
{
##dataprocessing
DollarSize= DollarSize
ProductId=as.numeric(ProductId)  
ProductId<-replace(ProductId,ProductId==425,424) 
ProductId<-replace(ProductId,ProductId==420,26) 
ProductId<-replace(ProductId,ProductId==421,460) 
ProductId<-replace(ProductId,ProductId==465,460) 
ProductId<-replace(ProductId,ProductId==25,426) 
ProductId<-replace(ProductId,ProductId==108,23) 
ProductId<-replace(ProductId,ProductId==464,23)
MakerClearedCheckCount=as.numeric(MakerClearedCheckCount)
PayeeUnclearedAmountInstantOnly=as.numeric(PayeeUnclearedAmountInstantOnly)
LyonsCode=as.numeric(LyonsCode)
Counts_MOW
Counts_OnlyPreviouslyDeclinedHistory
MakerUnClearedCheckCount=as.numeric(MakerUnClearedCheckCount)
TellerSuspicion=as.numeric(TellerSuspicion)
Counts_MOH
PayeeMakerUnClearedCombinedCheckCount=as.numeric(PayeeMakerUnClearedCombinedCheckCount)
Customer_Freq_144=as.numeric(Customer_Freq_144)
MakerNewCustomerFreq_NT=as.numeric(MakerNewCustomerFreq_NT)
checknumber<- as.numeric(checknumber)
Checknumberflag1500<- case_when(checknumber<= 1500 ~ 1 ,TRUE  ~ 0)
Hour <- as.numeric(Hour)
Hourbreak <- case_when( Hour<= 5 ~ "Dawn",
  Hour<= 9 ~ "Morning",
  Hour<= 20 ~ "Peak",
  TRUE ~ "Midnight")
Count_DNCDeclines_90days=as.numeric(Count_DNCDeclines_90days)
Statecustomer<- case_when(
  CustomerState %in% c('UM','TE','PR','AK','CA','WA','NM','UT','NV','AZ') ~ 1 ,
  CustomerState %in% c('KS','AR','OK','HI','GA','ND','TX','OR','FL','MT','MS','CO','AL','LA','TN','SC','MO','ID','NE') ~ 2,
  CustomerState %in% c('KY','WI','MN','WV','NC','IN','IL','IA','DC','OH','MI','VA','MD','NY','PA','NJ','WY','DE','NH') ~ 3,
  CustomerState %in% c('MA','SD','CT','VT','RI','ME','AS') ~ 4 ) 
latlonbadges = as.numeric(latlonbadges)
Ageattimeoftrans=as.numeric(Ageattimeoftrans)
Age <- case_when(Ageattimeoftrans >= 60 ~1,TRUE ~ 0)

new_data<-  data.frame(DollarSize= DollarSize, ProductId,MakerClearedCheckCount,PayeeUnclearedAmountInstantOnly,LyonsCode,Counts_MOW,Counts_OnlyPreviouslyDeclinedHistory,MakerUnClearedCheckCount,
                       TellerSuspicion,Counts_MOH,PayeeMakerUnClearedCombinedCheckCount,Customer_Freq_144,MakerNewCustomerFreq_NT,Checknumberflag1500,Hourbreak,Count_DNCDeclines_90days,Statecustomer,
                       latlonbadges,Age)
(1-predict(model, newdata = new_data,type="prob")[,2])*1000
  
}

##### For LOCAL TESTING, uncomment this to test the above function
#predict_autodecline("$500-$700",23, 0 ,600, 101, "False", "False", 1, 0, "False" ,10, 0 ,10, 1398, 20, 0, "NJ", 0, 61)
#####