# Stack Overflow, Twitter, and Slack
Integration between Stackoverflow, Twitter, and Slack for the JuliaLang.slack.com workspace. 

Every 30 minutes, a GitHub Action will run, which pings the StackOverflow API for new [Julia tagged questions](https://stackoverflow.com/questions/tagged/julia). 
If there are new questions, it posts them in the `#stackoverflow-feed` channel on the [JuliaLang Slack](https://julialang.org/slack/) and on [Twitter](https://twitter.com/JuliaOverflow).

Every even numbered day of the month at 11 AM UTC time, un-answered questions will be re-posted. 

This project is built in pure Julia and uses [Slack.jl](https://github.com/logankilpatrick/Slack.jl) as well as [StackOverflow.jl](https://github.com/logankilpatrick/StackOverflow.jl). 

## Current state

The code for this repo should now be in a static state and 100% Julia (yay). The only change on the near horizon is that Re-posted questions will be sent as a threaded message. This integration will happen in Slack.jl and then be utilized here. 

All feeedback / suggestions / feature requests are welcome! Just open an issue on this repo. 

## Env Secrets

`JULIALANGSLACKENDPOINT` should be in the form or `/services/TQVJBU534/BR8C1LMPS/42thawJz34SWSgZCpniyLBSE`. See https://github.com/JuliaLangSlack/Slack.jl#usage for more details.

## Resources
[YML Check](https://yamlchecker.com)

[Slack App settings page](https://api.slack.com/apps/AN12MEVDH/general?)

[Slack Message formatting check](https://api.slack.com/docs/messages/builder?msg=%7B%22text%22%3A%20%22This%20is%20a%20line%20of%20text.%5CnAnd%20this%20is%20another%20one.%22%7D)

[GitHub Action Scheduling Docs](https://help.github.com/en/articles/events-that-trigger-workflows#scheduled-events-schedule)

[Slack.jl](https://github.com/logankilpatrick/Slack.jl)

[StackOverflow.jl](https://github.com/logankilpatrick/StackOverflow.jl)
