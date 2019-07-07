import json
import urllib.request
from urllib import request
from urllib import error
localhost_port_num = '22002'
server_status_req = request.Request('http://localhost:22002/NeuLogAPI?GetSeverStatus')
Respiration_value_req = request.Request('http://localhost:22002/NeuLogAPI?GetSensorValue:[Respiration],[1]')
Respiration_StartExperiment_req=request.Request('http://localhost:22002/NeuLogAPI?StartExperiment:[Respiration],[1],[EKG],[1],[6],[240]')
StopExperiment_req= ('http://localhost:22002/NeuLogAPI?StopExperiment')
GetExperimentSamples_req=('http://localhost:22002/NeuLogAPI?GetExperimentSamples:[Respiration],[1],[EKG],[1]')

def get_server_version(object = server_status_req):
    try:
        response = urllib.request.urlopen(object).read()
        server_connect = json.loads(response)
##        print(server_connect['GetSeverStatus'])
        return server_connect['GetSeverStatus']
    except error.URLError as e:
        print ('Error: No Response From Server.')


def get_Respiration_value(object = Respiration_value_req):
    """ Captures Operators Current GSR Reading.
        Returns Parsed JSON containing GSR Value.
    """
    try:
        response = urllib.request.urlopen(object).read()
        Respiration_value = json.loads(response)
##        print(Respiration_value['GetSensorValue'][0])
        return Respiration_value['GetSensorValue'][0]
    except error.URLError as e:
        print ('Error: No Respiration Value.')

def Respiration_StartExperiment(object =Respiration_StartExperiment_req):
    """ Captures Operators Current GSR Reading.
        Returns Parsed JSON containing GSR Value.
    """
    try:
        response = urllib.request.urlopen(object).read()
        Respiration_Start = json.loads(response)
##        print(Respiration_Start['StartExperiment'])
        
        return Respiration_Start['StartExperiment']
    except error.URLError as e:
        print ('Error:Experiment.')

def StopExperiment(object = StopExperiment_req):
    try:
        response = urllib.request.urlopen(object).read()
        server_Stop = json.loads(response)
##        print(server_Stop['StopExperiment'])
        return server_Stop['StopExperiment']
    except error.URLError as e:
        print ('Error: No Stop.')
##while(1):

def GetExperimentSamples(object =GetExperimentSamples_req):
    try:
        response = urllib.request.urlopen(object).read()
        a= json.loads(response)
##        print(server_Stop['StopExperiment'])
        return a
    except error.URLError as e:
        print ('Error: No Stop.')

     
##get_server_version()
##Respiration_StartExperiment()
##a=GetExperimentSamples()
##StopExperiment()
##get_Respiration_value()
#Respiration_StartExperiment()
