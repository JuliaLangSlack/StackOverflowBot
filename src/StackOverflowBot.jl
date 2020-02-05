using StackOverflow, Dates, HTTP, Slack

endpoint = ARGS[1]

currenttime = trunc(Int64,floor(Dates.time())) #Get current time in Unix Epcot Time
thirtyMinsAgo = currenttime - 1800 #rewind 30 minutes since that's the frequency the job run's at.
posts = getrecentquestionsfortag(fromdate = string(thirtyMinsAgo), todate = string(currenttime))

for question in posts
    link = question.link[1]
    view_count = question.view_count[1]
    owner = question.owner[1]
    score = question.score[1]
    title = question.title[1]
    answer_count = question.answer_count[1]

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
