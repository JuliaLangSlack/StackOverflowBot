using StackOverflow, Dates, HTTP, Slack

currenttime = trunc(Int64,floor(Dates.time())) #Get current time in Unix Epcot Time
thirtyMinsAgo = currenttime - 1800 #rewind 30 minutes since that's the frequency the job run's at.
posts = getrecentquestionsfortag(fromdate = string(thirtyMinsAgo), todate = string(currenttime))

API_Key = ARGS[1]
API_Key_Secret = ARGS[2]
Access_Token = ARGS[3]
Access_Token_Secret = ARGS[4]

twitterauth(API_Key, API_Key_Secret, Access_Token, Access_Token_Secret)

for question in posts
    link = question.link[1]
    
    title = question.title[1]

    post_status_update(status="$title #JuliaLang \n $link")
end