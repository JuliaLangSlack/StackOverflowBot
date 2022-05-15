using StackOverflow, Dates, HTTP, Twitter

currenttime = trunc(Int64,floor(Dates.time())) #Get current time in Unix Epcot Time
thirtyMinsAgo = currenttime - 1800 #rewind 30 minutes since that's the frequency the job run's at.
posts = getrecentquestionsfortag(fromdate = string(thirtyMinsAgo), todate = string(currenttime))

API_Key = ARGS[1]
API_Key_Secret = ARGS[2]
Access_Token = ARGS[3]
Access_Token_Secret = ARGS[4]

twitterauth(API_Key, API_Key_Secret, Access_Token, Access_Token_Secret)

for question in posts
    link = question.link
    
    title = question.title

    myStatus = "$title #JuliaLang \n $link"
    
    # Get the 20 most recent tweets this account has liked
    tweets = get_favorites_list()
    
    # Loop through and check if the text is the same from any of the last 20 tweets
    newTweet = true
    for tweet in tweets
        if occursin(link, tweet.text)
            newTweet = false
        end
    end
    
    if newTweet == true
        myTweet = post_status_update(status=myStatus)
        
        # Like every tweet we put out
        post_favorites_create(id=myTweet.id)
    
    else
        print("Duplicate tweet with link: $link .... avoided")
    end    
    
end
