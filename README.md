# StackoverflowAndSlack
Integration between Stackoverflow and Slack for the JuliaLang.slack.com workspace. 

Every 30 mminutes, a GitHub Action will run that pings the StackOverflow API to see if there's any new questions. If there is, it post's them in the #stackoverflow-bridged channel on the JuliaLang SLack. 


YML Check: https://yamlchecker.com

Python SO API Package: https://stackapi.readthedocs.io/en/latest/user/complex.html

Curl to Python conversion: https://curl.trillworks.com/#python

Slack App settings page: https://api.slack.com/apps/AN12MEVDH/general?
