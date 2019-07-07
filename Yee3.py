import socket
import struct
import re
import json
import time

y1='192.168.1.102'
y2='192.168.1.109'
y3='192.168.1.100'
y4='192.168.1.103'

MCAST_GRP = '239.255.255.250'
MCAST_PORT = 1982
SRC_PORT = 7600 # my random port

CR_LF = "\r\n"

def get_ip_port():
  #return ('192.168.1.25', 55443)

  sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP)
  sock.setsockopt(socket.IPPROTO_IP, socket.IP_MULTICAST_TTL, 2)
  sock.bind(('', SRC_PORT))
  # need to ensure byte format for Python3
  msg = "M-SEARCH * HTTP/1.1\r\n" 
  msg = msg + "HOST: 239.255.255.250:1982\r\n"
  msg = msg + "MAN: \"ssdp:discover\"\r\n"
  msg = msg + "ST: wifi_bulb\r\n"
##  command = "M-SEARCH * HTTP/1.1\r\nHOST: 239.255.255.250:1982\r\nMAN:'ssdp:discover'\r\nST: wifi_bulb\r\n"
  sock.sendto(bytes(msg, 'utf-8'), (MCAST_GRP, MCAST_PORT))
##  sock.sendto(command, (MCAST_GRP, MCAST_PORT))
  sock.close()
  
  sock_recv = socket.socket(socket.AF_INET, socket.SOCK_DGRAM,
                            socket.IPPROTO_UDP)
  # ensure this socket is listening on the same
  # port as the multicast went on
  sock_recv.bind(('', SRC_PORT))
  response = sock_recv.recv(10240)
  response = response.decode('utf-8')
##  print(response)
  sock_recv.close()

  # match on a line like "Location: yeelight://192.168.1.25:55443"
  # to pull ip out of group(1), port out of group(2)
  prog = re.compile("Location: yeelight://(\d*\.\d*\.\d*\.\d*):(\d*).*")
  for line in response.splitlines():
    result = prog.match(line)
    if result != None:
      ip = result.group(1)
      port = result.group(2)
      return (ip, int(port))
##  return (None, None)
##q=get_ip_port()



def sendto(ip, port, command):
  sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM, socket.IPPROTO_TCP)
  sock.connect((ip, port))
  sock.send(bytes(command + CR_LF, 'utf-8'))
  response = sock.recv(10240)
  #print(response)

  # the response is a JSON string, parse it and return
  # the "result" field
  dict = json.loads(response)
  sock.close()
  #print "Response was ", response
  return(dict["result"])

def set_prop(prop, params, ip, port):
  # hard code the JSON string
  command = '{"id":1,"method":"set_' + prop +\
            '", "params":' + params +\
            '}'
##  print(command)
  response = sendto(ip, port, command)
  return response

def set_bright(state, ip, port):
  params = '[' + str(state) + ', "smooth", 30]'
  response = set_prop('bright', params, ip, port)
  return response

def set_bright1(state,ip,port):
  params='['+str(state)+',"sudden"]'
  response = set_prop('bright', params, ip, port)


  
def change_color(color,ip,port):
  params='['+str(color)+',"smooth",30]'
  response=set_prop('rgb', params, ip, port)
  return response

def red():
  change_color(1507328,y1,55443)
  change_color(1507328,y2,55443)
  change_color(1507328,y3,55443)
  change_color(1507328,y4,55443)
  
def green():
  change_color(3840,y1,55443)
  change_color(3840,y2,55443)
  change_color(3840,y3,55443)
  change_color(3840,y4,55443)
  
def blue():
  change_color(1,y1,55443)
  change_color(1,y2,55443)
  change_color(1,y3,55443)
  change_color(1,y4,55443)
  
def white():
  change_color(100000,y1,55443)
  change_color(100000,y2,55443)
  change_color(100000,y3,55443)
  change_color(100000,y4,55443)

def shangshuo():
  

  for i in range(1,3):
####  s=set_bright(90,'192.168.1.109',55443)
#### 
####  c=change_color(90000,'192.168.1.109',55443)
####  time.sleep(1)
####  q=set_bright(10,'192.168.1.109',55443)
####  d=change_color(20,'192.168.1.109',55443)
####  time.sleep(1)
##  change_color(1507328,'192.168.1.109',55443)
##  time.sleep(1)
##  change_color(3840,'192.168.1.109',55443)
##  time.sleep(1)
##change_color(7,'192.168.1.100',55443)
##    white()
    set_bright(100,y1,55443)
    set_bright(100,y2,55443)
    set_bright(100,y3,55443)
    set_bright(100,y4,55443)
    time.sleep(0.2)
    set_bright(10,y1,55443)
    set_bright(10,y2,55443)
    set_bright(10,y3,55443)
    set_bright(10,y4,55443)
    time.sleep(0.2)
##for i in range(1,1000,10):
##  j=i*100
##  c=change_color(j,'192.168.1.109',55443)
##shangshuo()
##
