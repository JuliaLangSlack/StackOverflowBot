# Stackoverflow and Slack
Integration between Stackoverflow and Slack for the JuliaLang.slack.com workspace. 

Every 30 minutes, a GitHub Action will run, which pings the StackOverflow API for new [Julia tagged questions](https://stackoverflow.com/questions/tagged/julia). 
If there are, it posts them in the `#stackoverflow-bridged` channel on the [JuliaLang Slack](https://slackinvite.julialang.org). 

Every day at 11 AM UTC time, un-answered questions will be re-posted. 

## Current state
This repo is very much still WIP. All feeedback / suggestions / feature requests are welcome! Just open an issue on this repo. 

## How to use this repo as a template
The main thing you will need in order to use this code is repo is set up an appropriate WebHook for your Slack workspace and respective channel. And, unless there's another Slack out there interested in Julia (Invite me if there is), you will also need to edit the StackOverflow API query to match the tag and other parameters of your choosing. 

## Resources
YML Check: https://yamlchecker.com

Python SO API Package: https://stackapi.readthedocs.io/en/latest/user/complex.html

Curl to Python conversion: https://curl.trillworks.com/#python

Slack App settings page: https://api.slack.com/apps/AN12MEVDH/general?

Slack Message formatting check: https://api.slack.com/docs/messages/builder?msg=%7B%22text%22%3A%20%22This%20is%20a%20line%20of%20text.%5CnAnd%20this%20is%20another%20one.%22%7D

GitHub Action Scheduling Docs: https://help.github.com/en/articles/events-that-trigger-workflows#scheduled-events-schedule

