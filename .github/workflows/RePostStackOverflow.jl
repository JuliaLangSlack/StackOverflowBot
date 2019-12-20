using StackOverflow, Dates, HTTP, Slack

endpoint = ARGS[1]
yesterday = trunc(Int64,floor(Dates.time()))- 86400
eightDaysAgo = (yesterday - 604800)
posts = getrecentquestionsfortag(fromdate = string(eightDaysAgo), todate = string(yesterday))

for question in posts
    link = question.link[1]
    view_count = question.view_count[1]
    owner = question.owner[1]
    score = question.score[1]
    title = question.title[1]
    answer_count = question.answer_count[1]
    if (answer_count == 0)
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
end
