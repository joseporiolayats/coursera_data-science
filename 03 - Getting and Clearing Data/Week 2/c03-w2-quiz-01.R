###################################################################################################
## This is the script for the course from
## Coursera
## Getting and Cleaning Data
## Week 2
## Quiz
## Exercise 1
##
## QUESTION:
## Register an application with the Github API here https://github.com/settings/applications.
## Access the API to get information on your instructors repositories
## (hint: this is the url you want "https://api.github.com/users/jtleek/repos").
## Use this data to find the time that the datasharing repo was created. What time was it created?
## This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r)
###################################################################################################

library(httr)

# 0. Data we want

url <- "https://api.github.com/repos/jtleek/datasharing"

# 1. Find OAuth settings for github:

oauth_endpoints("github")

# 2. Key and secret below.
myapp <- oauth_app("github",
                   key = "c57141779d42947277f6",
                   secret = "eb4752d00624bb77ac699046e2ccd51c2ce823fd"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET(url, gtoken)
stop_for_status(req)
content(req)


## look for $created_at for the answer
content(req)$created_at
