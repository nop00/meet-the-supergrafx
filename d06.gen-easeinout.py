import math


nbCoords = 128
origin = 0
coords1 = "d06.easeout: "
coords2 = "d06.easein: "
comma = ", "

speed = 0.70158;
duration = 1200.0 # in ms
begin = 0
change = 270
previousvalue = 0

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

    coords1 += str(previousvalue - coord) + comma
    previousvalue = coord

begin = 0
change = 255 - 80
previousvalue = 0
for i in range(0, nbCoords):
    time = duration / nbCoords * i
    time = time / duration - 1.0

    #return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
    coord = int(change * (time * time * ((speed + 1.0) * time + speed) + 1.0) + begin)

    if i % 16 == 15:
        comma = ""
    else:
        comma = ", "

    if i % 16 == 0:
        coords2 += "\n    .dw "

    coords2 += str(previousvalue - coord) + comma
    previousvalue = coord


f = open('d06.easeinout.asm', 'w+')
f.write(coords1)
f.write('\n')
f.write(coords2)
f.write('\n')
f.close()
	
