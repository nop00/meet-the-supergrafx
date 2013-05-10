import math


nbCoords = 64
origin = 220
boing = "boing: "
comma = ", "

for i in range(0, nbCoords):
    value = (2.0 / nbCoords) * i - 1.0
    print value
    coord = int((-(value * value) + 1.0) * 50.0 + origin)

    if i % 16 == 15:
        comma = ""
    else:
        comma = ", "

    if i % 16 == 0:
        boing += "\n    .dw "

    boing += str(coord) + comma

f = open('d20.boing.asm', 'w+')
f.write(boing)
f.write('\n')
f.close()

