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
            answer_count = ""
            link = ""            
            for k,v in item.items():
                
                if k == "title":
                    title = v
                    #print("Title1: " + str(title)) #Used for DEBUG                    
                elif k == "owner":
                    for name_key, name_value in v.items():
                        if name_key == "display_name":
                            owner = name_value
                    #print("Owner1: " + str(owner)) #Used for DEBUG
                elif k == "answer_count":
                    #print("answer_count" + str(v)) #Used for DEBUG  
                    answer_count = v
                elif k == "link":
                    link = v
                    currenttime = int(time.time())  
                    
                    #print("Title2: " + str(title)) #Used for DEBUG                    
                    #print("Owner2: " + str(owner)) #Used for DEBUG
                    #print("answer_count" + str(v)) #Used for DEBUG
                    
                    data = ('{ "attachments": [ { "color": "#36a64f", "title": "%s", "title_link": "%s", "footer": "Slack API", "ts": %d, "fields": [ { "title": "Answer Count: %s", "short": false } ] } ] }' % (str(title), link, currenttime, str(answer_count)))
                    #print(data + "\n") #Used for DEBUG
                    
                    response = requests.post(webHookURL, headers=headers, data=data)
                    
                    print(response)
                    
                #End of if
            #End of for
        #End of internal for loop. 
    #End of if. 
#End of for
