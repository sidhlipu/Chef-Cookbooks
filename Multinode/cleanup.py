#!/usr/bin/python
#@siddharth.mohapatra@oracle.com
#This script takes care of cleaning up multi-node environment setup
import os,sys
hosts={}
MultinodePath='/u01/work'
with open(MultinodePath+'/hosts','r') as f:
        for line in f:
                hosts[line.strip().split('=')[0]]=line.strip().split('=')[1]
def child(host):
   os.system("ssh "+host+" 'rm -rf "+MultinodePath+"/*;reboot'")
   os._exit(0) # else goes back to parent loop

def runClean():
	hosts={}
	with open(MultinodePath+'/hosts','r') as f:
        	for line in f:
                	hosts[line.strip().split('=')[0]]=line.strip().split('=')[1]
    	for host in sorted(hosts.values(),reverse=True):
        	newpid = os.fork()
        	if newpid == 0:
            		child(host)
        	else:
            		print('Started cleaning on '+host+' with pid:',host,newpid)
            		var1=os.wait()
            		if var1[1] == 0:
                		print "Success"

os.system("knife exec -E 'nodes.transform(:all) {|n| n.run_list([\"role[primary-role]\"])}'")
os.system("knife exec -E 'nodes.find(\"role:primary-role\") {|n| n.run_list.remove(\"role[primary-role]\"); n.save}'")
runClean()

