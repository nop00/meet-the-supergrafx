import math


nbCoords = 128
origin = 0
coords1 = "d05.easeout: "
comma = ", "

speed = 0.70158;
duration = 1200.0 # in ms
begin = 0
change = 256

for i in range(0, nbCoords):
    time = duration / nbCoords * i
    time = time / duration
    #return c*(t/=d)*t*((s+1)*t - s) + b;
    coord = int(change * (time * time * ((speed + 1.0) * time - speed)) + begin)

    if i % 16 == 15:
        comma = ""
    else:
        comma = ", "

    if i % 16 == 0:
        coords1 += "\n    .dw "

    coords1 += str(coord) + comma
    previousvalue = coord

    #return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
    #coord = int(change * (time * time * ((speed + 1.0) * time + speed) + 1.0) + begin)

f = open('d05.easeout.asm', 'w+')
f.write(coords1)
f.write('\n')
f.close()
	
