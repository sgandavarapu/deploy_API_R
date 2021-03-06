FROM trestletech/plumber
LABEL maintainer="niha"
RUN export DEBIAN_FRONTEND=noninteractive; apt-get -y update \
 && apt-get install -y libcairo2-dev \
	libcurl4-openssl-dev \
	libgmp-dev \
	libpng-dev \
	libssl-dev \
	libxml2-dev \
	make \
	pandoc \
	pandoc-citeproc \
	zlib1g-dev

#RUN ["install2.r", "-r 'http://cloud.r-project.org'", "readr", "googleCloudStorageR", "Rcpp", "digest", "crayon", "withr", "mime", "R6", "jsonlite", "xtable", "magrittr", "httr", "curl", "testthat", "devtools", "hms", "shiny", "httpuv", "memoise", "htmltools", "openssl", \
    #"tibble", "remotes", "rjson", "rpart", "caret", "dplyr"]
RUN ["install2.r", "-r 'http://cloud.r-project.org'","Rcpp", "dplyr", "rjson", "rpart", "jsonlite", "caret", "googleCloudStorageR", "remotes", "formatR", "miniUI"]
RUN ["installGithub.r", "MarkEdmondson1234/googleAuthR", "hadley/rlang"]
WORKDIR /payload/
COPY [".", "./"]
VOLUME /Users/sxg0748/Documents/workspace/deploy_API_R/keyfile.json:/payload/keyfile.json

EXPOSE 8080
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(commandArgs()[4]); pr$run(host='0.0.0.0', port=8080)"]
CMD ["deploy_ml_model.R"]
