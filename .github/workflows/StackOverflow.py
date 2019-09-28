from stackapi import StackAPI
import time
import requests
import sys

webHookURL = sys.argv[1]

SITE = StackAPI('stackoverflow')

currenttime = int(time.time()) #Get current time in Unix Epcot Time

thirtyMinsAgo = currenttime - 1800 #rewind 30 minutes since that's the frequency the job run's at. 

posts = SITE.fetch('questions', fromdate = thirtyMinsAgo, todate = currenttime, tagged = 'Julia')

headers = {
    'Content-type': 'application/json',
}

for k,v in posts.items():
    if k == "items":
        #print("KEY: " + str(k) + " VALUES: " + str(v))
        for item in v: 
            title = ""
            owner = ""
            is_answered = ""
            link = ""            
            for k,v in item.items():
                
                if k == "title":
                    title = v
                elif k == "owner":
                    for name_key, name_value in v.items():
                        if name_key == "display_name":
                            owner = name_value
                    #print("Owner: " + str(owner)) #Used for DEBUG
                elif k == "is_answered":
                    print("is_answered" + str(v))
                    is_answered = v
                elif k == "link":
                    link = v
                    currenttime = int(time.time())
                    data = ('{ "attachments": [ { "color": "#36a64f", "author_name": "author_name : %s", "title": "%s", "title_link": "%s", "text": "%s", "footer": "Slack API", "ts": %d, "fields": [ { "title": "Is Answered", "value": "%s", "short": false } ] } ] }' % (owner, title, link, link, currenttime, is_answered))
                    
                    response = requests.post(webHookURL, headers=headers, data=data)
                    
                    print(response)
                    
                #End of if
            #End of for
        #End of internal for loop. 
    #End of if. 
#End of for
