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
            for k,v in item.items():
                if k == "link":
                    print(v)
                    data = ('{"text":"%s"}' % v)
                    
                    response = requests.post(webHookURL, headers=headers, data=data)
                    
                    print(response)
                #End of if
            #End of for
        #End of internal for loop. 
    #End of if. 
#End of for
