#To generate subsets of datasets with unique DOIs from a pre-defined dataset range (the pre-defined dataset range is sampled from DataONE)
#Date Created: 2015-02-04
#Created by: Sophie Hou
#Date Last Modified: 2015-02-04
#Last Modified by: Sophie Hou

import random
import requests

#The next line helps obtaining the Solr query result from DataONE
request = requests.get('https://cn.dataone.org/cn/v1/query/solr/?q=primary%20production%20id:doi*lter-and*&datasource:*LTER%20-obsoletedBy:*&fl=id&rows=20')

#The next line helps obtaining the Solr query result from DataONE in JSON
#request = requests.get('https://cn.dataone.org/cn/v1/query/solr/?q=primary%20production%20id:doi*lter-knz*&datasource:*LTER%20-obsoletedBy:*&fl=id&rows=5&wt=json')

requesttext = request.text #Obtaining the Solr query results in unicode text format.
parsedrequesttext = requesttext.split()

#The next line helps checking the content of the parsed text
#print "This is the parsed text", parsedrequesttext

#This for loop makes sure the DOIs are written to a file named "TestFile.txt"
linecount = 1
fo = open('TestFile.txt', 'w')
for item in parsedrequesttext:
    string = str(item)
    if string.startswith('name="id"'):
        doi = string[string.find(">")+1:string.find("<")]
        outputline = fo.write(str(linecount)+' '+doi+'\n')
        linecount = linecount + 1        
        #print "This is the item with DOI:", doi
fo.close()

#Initializing the user input for deciding whether or not to generate another set of random numbers from a range defined by "FullRange" variable.
UserInput = 'Y'

#Setting the range that the random numbers should be selected from
FullRange = range(1, linecount, 1)

while UserInput == 'Y':
    
    OneRun = random.sample(FullRange, 4) #Selecting a set of numbers from the "FullRange"
    print "The numbers for One Run are", OneRun

    for num in OneRun:
        #print "The following index number has been sampled and will be removed from the range:", num
        FullRange.remove(num)
        #print "The remaining index numbers in the range are the following:", FullRange
                  
    for x in OneRun:
        f = open('TestFile.txt', 'r') 
        line = f.readline() #readlines could be another option here.

        #Print out the full line that match the number we sampled.
        while line: 
            testline = line.split(' ')
               
            if int(testline[0]) == x:
                print testline #Writing to an output file could be another option here.
            line =  f.readline()
        f.close()

    if FullRange != []:    
        UserInput = raw_input("Would you like to choose another run? (Please enter 'Y' or 'N')")
    else:
        print "All the datasets have been sampled."
        UserInput = 'N'
        
#Beautifulsoup - XML

