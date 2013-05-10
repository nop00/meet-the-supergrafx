import math

comma = ", "
coords = "d11.textcoords:"

#return c*((t=t/d-1)*t*t + 1) + b;
begin = 255
change = -255
duration = 1000.0

for i in range (0, 64):
    t = (duration / 64.0 * i)
    t = t / duration - 1
    value = change * (t * t * t + 1) + begin

    if i % 8 == 7:
        comma = ""
    else:
        comma = ", "

    if i % 8 == 0:
        coords += "\n    .db "

    coords += str(int(value)) + comma

f = open('d11.text.coords.asm', 'w+')
f.write(coords)
f.write('\n')
f.close()
