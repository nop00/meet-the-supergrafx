import struct
import sys

f = open(r"C:\Documents and Settings\nop\Demo\PC Engine\tools\DefleMask_Windows\songs\Output\PCE\MeetTheSuperGrafx.vgm", 'rb')
contents = f.read()
f.close()
gd3offset = struct.unpack('L', contents[20:24])[0] + 20
rate = struct.unpack('L', contents[36:40])[0]
clock = struct.unpack('L', contents[164:168])[0]
dataoffset = struct.unpack('L', contents[52:56])
dataoffset = dataoffset[0] + 52
data = contents[dataoffset:gd3offset]

f = open("MeetTheSuperGrafx.vgm", 'w+b')
contents = f.write(data)
f.close()

print 'Rate: ', rate
print 'Clock: ', clock

print 'Done'

