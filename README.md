# Stackoverflow and Slack
Integration between Stackoverflow and Slack for the JuliaLang.slack.com workspace. 

Every 30 minutes, a GitHub Action will run, which pings the StackOverflow API for new [Julia tagged questions](https://stackoverflow.com/questions/tagged/julia). 
If there are, it posts them in the `#stackoverflow-bridged` channel on the [JuliaLang Slack](https://slackinvite.julialang.org). 

## Current state
This repo is very much still WIP. All feeedback / suggestions / feature requests are welcome! Just open an issue on this repo. 

## Resources
YML Check: https://yamlchecker.com

Python SO API Package: https://stackapi.readthedocs.io/en/latest/user/complex.html

Curl to Python conversion: https://curl.trillworks.com/#python

Slack App settings page: https://api.slack.com/apps/AN12MEVDH/general?
