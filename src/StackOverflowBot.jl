using StackOverflow, Dates, HTTP, Slack

endpoint = ARGS[1]  # Where endpoint looks like: "/services/TQVJBU534/BR8C1LMPS/42thawJz34SWSgZCpniyLBSE" (just an example). 
# The bot uses Endpoint URL's to send messages. Find our more here: https://api.slack.com/apps/AN12MEVDH/incoming-webhooks?success=1
# A new endpoint needs to generated for each channel you want to send posts too.

currenttime = trunc(Int64,floor(Dates.time())) #Get current time in Unix Epcot Time
thirtyMinsAgo = currenttime - 1800 #rewind 30 minutes since that's the frequency the job run's at.
posts = getrecentquestionsfortag(fromdate = string(thirtyMinsAgo), todate = string(currenttime))

for question in posts
    link = question.link
    view_count = question.view_count
    owner = question.owner
    score = question.score
    title = question.title
    answer_count = question.answer_count

    data = Dict("attachments" => [Dict("color" => "#36a64f",
                                        "title" => "$(string(title))",
                                        "title_link" => "$(link)",
                                        "text" => "$(link)",
                                        "footer" => "Slack API",
                                        "ts" => "$(string(currenttime))",
                                        "fields" => [Dict("title" => "Answer Count: $(answer_count)", "short" => false)]
                                    )])
    
    response = sendattachmenttoslack(data, endpoint)
    println(response)
end
