using StackOverflow, Dates, HTTP, Slack

endpoint = ARGS[1]  # Where endpoint looks like: "/services/TQVJBU534/BR8C1LMPS/42thawJz34SWSgZCpniyLBSE" (just an example). 
# The bot uses Endpoint URL's to send messages. Find our more here: https://api.slack.com/apps/AN12MEVDH/incoming-webhooks?success=1
# A new endpoint needs to generated for each channel you want to send posts too.

currenttime = trunc(Int64,floor(Dates.time())) #Get current time in Unix Epcot Time
thirtyMinsAgo = currenttime - 1800 #rewind 30 minutes since that's the frequency the job run's at.
posts = getrecentquestionsfortag(fromdate = string(thirtyMinsAgo), todate = string(currenttime))

API_Key = ARGS[2]
API_Key_Secret = ARGS[3]
Access_Token = ARGS[4]
Access_Token_Secret = ARGS[5]

twitterauth(API_Key, API_Key_Secret, Access_Token, Access_Token_Secret)

for question in posts
    link = question.link[1]
    
    title = question.title[1]

    post_status_update(status="$title #JuliaLang \n $link")
end