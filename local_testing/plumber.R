library(plumber)
r <- plumb("/Users/sxg0748/Documents/workspace/deploy_API_R/deploy_ml_model.R")
r$run(port=8000)



#Reference: https://github.com/MarkEdmondson1234/serverless-R-API-appengine/blob/master/demoDockerAppEngine/README.md

