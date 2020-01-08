using StackOverflow, Dates, HTTP, Slack

endpoint = ARGS[1]
yesterday = trunc(Int64,floor(Dates.time()))- 86400
currenttime = Dates.time()
eightDaysAgo = (yesterday - 604800)
flag_holder = false
posts = getrecentquestionsfortag(fromdate = string(eightDaysAgo), todate = string(yesterday))

for question in posts
    
    global flag_holder
    
    if flag_holder == false
        response = sendtoslack("The following questions are being re-posted since no one answered yet:", endpoint)
        println(response)
        flag_holder = true
    end
    
    link = question.link[1]
    view_count = question.view_count[1]
    owner = question.owner[1]
    score = question.score[1]
    title = question.title[1]
    answer_count = question.answer_count[1]
    if (answer_count == 0)
        data = Dict("attachments" => [Dict("color" => "#fd1919",
                                            "title" => "$(string(title))",
                                            "title_link" => "$(link)",
                                            "text" => "$(link)",
                                            "footer" => "Slack API",
                                            "ts" => "$(trunc(Int64,floor(Dates.time())))",
                                            "fields" => [Dict("title" => "Answer Count: $(answer_count)", "short" => false)]
                                        )])
        response = sendattachmenttoslack(data, endpoint)
        println(response)
    end
end
