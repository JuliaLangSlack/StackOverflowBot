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
        for item in v:
            title = ""
            owner = ""
            answer_count = ""
            link = ""            
            for key,value in item.items():
                #print("Key: " + str(key) + " Value: " + str(value)) #Used for DEBUG
                
                if key == "title":
                    title = value
                    #print("Title1: " + str(title)) #Used for DEBUG                    
                elif key == "owner":
                    for name_key, name_value in value.items():
                        if name_key == "display_name":
                            owner = name_value
                elif key == "answer_count":
                    answer_count = value
                elif key == "link":
                    link = value
                   
                #End of if
                
            #End of for
            
            currenttime = int(time.time()) 
            data = ('{ "attachments": [ { "color": "#36a64f", "title": "%s", "title_link": "%s", "text": "%s", "footer": "Slack API", "ts": %d, "fields": [ { "title": "Answer Count: %s", "short": false } ] } ] }' % (str(title), link, link, currenttime, str(answer_count)))
            
            # print(data + "\n") #Debug. 
            
            # WARNING: Un-commenting this line will push to prod. 
            response = requests.post(webHookURL, headers=headers, data=data)
            print(response)
            # WARNING     
                            
        #End of internal for loop. 
    #End of if. 
#End of for
