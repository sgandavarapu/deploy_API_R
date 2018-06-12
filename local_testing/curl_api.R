#install.packages("RCurl")
library("RCurl")
url <- "http://127.0.0.1:8000/predict"
postForm(url,
         DollarSize="$500-$700",
         ProductId=23,
         MakerClearedCheckCount=0,
         PayeeUnclearedAmountInstantOnly=600,
         LyonsCode=101,
         Counts_MOW="False",
         Counts_OnlyPreviouslyDeclinedHistory="False",
         MakerUnClearedCheckCount=1,
         TellerSuspicion=0,
         Counts_MOH="False",
         PayeeMakerUnClearedCombinedCheckCount=10,
         Customer_Freq_144=0,
         MakerNewCustomerFreq_NT=10,
         checknumber=1398,
         Hour=20,
         Count_DNCDeclines_90days=0,
         CustomerState="NJ",
         latlonbadges=0,
         Ageattimeoftrans=61, 
         style = "POST")

#Local Curl
##curl -X POST -d '{"DollarSize":"$500-$700","ProductId":23,"MakerClearedCheckCount":0,"PayeeUnclearedAmountInstantOnly":600,"LyonsCode":101,"Counts_MOW":"False","Counts_OnlyPreviouslyDeclinedHistory":"False","MakerUnClearedCheckCount":1,"TellerSuspicion":0,"Counts_MOH":"False","PayeeMakerUnClearedCombinedCheckCount":10,"Customer_Freq_144":0,"MakerNewCustomerFreq_NT":10,"checknumber":1398,"Hour":20,"Count_DNCDeclines_90days":0,"CustomerState":"NJ","latlonbadges":0,"Ageattimeoftrans":61}' -H 'Content-Type: application/json' localhost:8000/predict

#GCP Curl
##curl -X POST -d '{"DollarSize":"$500-$700","ProductId":23,"MakerClearedCheckCount":0,"PayeeUnclearedAmountInstantOnly":600,"LyonsCode":101,"Counts_MOW":"False","Counts_OnlyPreviouslyDeclinedHistory":"False","MakerUnClearedCheckCount":1,"TellerSuspicion":0,"Counts_MOH":"False","PayeeMakerUnClearedCombinedCheckCount":10,"Customer_Freq_144":0,"MakerNewCustomerFreq_NT":10,"checknumber":1398,"Hour":20,"Count_DNCDeclines_90days":0,"CustomerState":"NJ","latlonbadges":0,"Ageattimeoftrans":61}' -H 'Content-Type: application/json' https://20180612t172707-dot-ingo-risk-ml.appspot.com/predict
