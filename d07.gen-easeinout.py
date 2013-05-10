import math


nbCoords = 256
origin = 0
coords = "easeinout: "
pictoscirclex = "pictoscirclex: "
pictoscircley = "pictoscircley: "
comma = ", "

speed = 0.70158;
speed *= 1.525
duration = 1200.0 # in ms
begin = 0
change = 256

for i in range(0, nbCoords):
    time = duration / 256.0 * i
    time /= duration / 2.0
    #if ((t/=d/2) < 1) return c/2*(t*t*(((speed*=(1.525))+1)*t - speed)) + b;
    if time < 1:
        coord = str(int(change / 2.0 * (time * time * ((speed + 1) * time - speed)) + begin))
    else:
		#return c/2*((t-=2)*t*(((speed*=(1.525))+1)*t + speed) + 2) + b;
        time -= 2.0
        coord = str(int(change / 2.0 * (time * time * ((speed + 1) * time + speed) + 2.0) + begin))

    if i % 16 == 15:
        comma = ""
    else:
        comma = ", "

    if i % 16 == 0:
        coords += "\n    .dw "

    coords += str(coord) + comma

poulpesin = "poulpesin: "
poulpesin2 = "poulpesin2: "
poulpeantisin = "poulpeantisin: "
poulpeantisin2 = "poulpeantisin2: "
amplitude = 50
begin = 80 + 64
nbCoords = 160

for i in range (0, 56):
    if i % 16 == 15 or i == 55:
        comma = ""
    else:
        comma = ", "

    if i % 16 == 0:
        poulpesin += "\n    .dw "
        poulpesin2 += "\n    .dw "
        poulpeantisin += "\n    .dw "
        poulpeantisin2 += "\n    .dw "
    
    coord = 80 + 64 + 9
    poulpesin += str(int(coord)) + comma
    poulpesin2 += str(int(coord + 18)) + comma
    coord = 80 + 64 - 9
    poulpeantisin += str(int(coord)) + comma
    poulpeantisin2 += str(int(coord - 18)) + comma

for i in range(0, nbCoords):
    t = (-math.pi / 2.0) + 2.0 * math.pi / nbCoords * i
    if i % 16 == 15:
        comma = ""
    else:
        comma = ", "

    if i % 16 == 0:
        poulpesin += "\n    .dw "
        poulpesin2 += "\n    .dw "
        poulpeantisin += "\n    .dw "
        poulpeantisin2 += "\n    .dw "

    coord = ((1.0 + math.sin(t)) / 2.0) * amplitude + begin
    poulpesin += str(int(coord + 9)) + comma
    poulpesin2 += str(int(coord + 9 + 18)) + comma

    coord = begin - ((1.0 + math.sin(t)) / 2.0) * amplitude
    poulpeantisin += str(int(coord - 9)) + comma
    poulpeantisin2 += str(int(coord - 9 - 18)) + comma


for i in range (0, 56):
    if i % 16 == 15 or i == 55:
        comma = ""
    else:
        comma = ", "

    if i % 16 == 0:
        poulpesin += "\n    .dw "
        poulpesin2 += "\n    .dw "
        poulpeantisin += "\n    .dw "
        poulpeantisin2 += "\n    .dw "
     
    coord = 80 + 64 + 9
    poulpesin += str(int(coord)) + comma
    poulpesin2 += str(int(coord + 18)) + comma
    coord = 80 + 64 - 9
    poulpeantisin += str(int(coord)) + comma
    poulpeantisin2 += str(int(coord - 18)) + comma

pictosx = ""
pictosy = ""
count = 103
for i in range (0, count):
    x = int((142) / float(count - 1.0) * i)
    value = math.pi / count * i
    if i % 16 == 15 or i == count - 1:
        comma = ""
    else:
        comma = ", "

    if i % 16 == 0:
        pictosx += "\n    .dw "
        pictosy += "\n    .dw "
     
    coord = (math.cos(value + math.pi) + 1) / 2 * 98 + 66
    pictosy += str(int(coord)) + comma
    pictosx += str(x) + comma

count = 102
for i in range (0, count):
    angle = (-math.pi * 2) / float(count - 1.0) * i
    point = [0,22]
    offset = [143 - point[0], 163 - point[1]]
    if i % 16 == 15 or i == count - 1:
        comma = ""
    else:
        comma = ", "

    if i % 16 == 0:
        pictosx += "\n    .dw "
        pictosy += "\n    .dw "
     
    x = point[0] * math.cos(angle) - point[1] * math.sin(angle)
    y = point[1] * math.cos(angle) + point[0] * math.sin(angle)
    #x2 = x * cos(angle) - y * sin(angle)
    #y2 = y * cos(angle) + x * sin(angle)
    #1 radian = 180/PI degrees 

    pictosx += str(int(x + offset[0])) + comma
    pictosy += str(int(y + offset[1])) + comma

count = 103
for i in range (0, count):
    x = int((287 - 142) / float(count - 1.0) * i) + 143
    value = math.pi / count * i
    if i % 16 == 15 or i == count - 1:
        comma = ""
    else:
        comma = ", "

    if i % 16 == 0:
        pictosx += "\n    .dw "
        pictosy += "\n    .dw "
     
    coord = (math.cos(value) + 1) / 2 * 98 + 66
    pictosy += str(int(coord)) + comma
    pictosx += str(x) + comma


f = open('d07.easeinout.asm', 'w+')
f.write(coords)
f.write('\n')
f.write(poulpesin)
f.write('\n')
f.write(poulpesin2)
f.write('\n')
f.write(poulpeantisin)
f.write('\n')
f.write(poulpeantisin2)
f.write('\n')
f.write("pictosxbefore:" + pictosx)
f.write('\n')
f.write("pictosx:" + pictosx)
f.write('\n')
f.write("pictosybefore:" + pictosy)
f.write('\n')
f.write("pictosy:" + pictosy)
f.write('\n')
f.close()
	
