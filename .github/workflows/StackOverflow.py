from stackapi import StackAPI
import time
import os
import requests

SITE = StackAPI('stackoverflow')

currenttime = int(time.time()) #Get current time in Unix Epcot Time

oneHourAgo = currenttime - 36000 #rewind 10 hours for this test. 

posts = SITE.fetch('questions', fromdate = oneHourAgo, todate = currenttime, tagged = 'Julia')

headers = {
    'Content-type': 'application/json',
}

for k,v in posts.items():
    if k == "items":
        #print("KEY: " + str(k) + " VALUES: " + str(v))
        for item in v: 
            for k,v in item.items():
                if k == "link":
                    print(v)
                    data = ('{"text":"%s"}' % v)
                    
                    response = requests.post('https://hooks.slack.com/services/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', headers=headers, data=data)
                    
                    print(response)
                #End of if
            #End of for
        #End of internal for loop. 
    #End of if. 
#End of for
