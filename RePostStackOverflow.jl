#=
RePostStackOverflow:
- Julia version: 1.0.4
- Author: pepsipu
- Date: 2019-12-04
=#

using StackOverflow
using HTTP
using Dates
using JSON

endpoint = "/services/TR8BQV1U4/BR2K9KQC9/x3JoBxwBBHA5wGuld5pXtfya"
epochYesterday = trunc(Int, Dates.datetime2unix(Dates.now())) - 86400
eightDaysAgo = epochYesterday - 604800
questions = getrecentquestionsfortag(tag = "julia", fromdate = string(epochYesterday), todate = string(eightDaysAgo))
for question in questions
    if question.answer_count[1] == 0
        data = Dict(
            "attachments" => [
                "color" => "#36a64f",
                "title" => question.title[1],
                "title_link" => question.link[1],
                "text" => question.link[1],
                "footer" => "Slack API",
                "ts" => string(trunc(Int, Dates.datetime2unix(Dates.now()))),
                "fields" => [
                    Dict(
                        "title" => "Answer Count: $(question.answer_count[1])",
                        "short" => false
                    )
                ]
            ]
        )
        HTTP.setuseragent!("Julia Slack Bot")
        r = HTTP.post(
            "https://hooks.slack.com" * endpoint,
            ["Content-Type" => "application/json"],
            JSON.json(data)
        )
    end
end