import math

comma = ", "
tables = ""

for multiplicator in range (2, 33):
    tables += "multables" + str(multiplicator) + ":"
    for i in range(0, 256):
        value = (i * multiplicator)
        value = value % 256
        #bla = math.floor(value / 256.0)
        #if bla % 2 != 0:
            #value = 256 - (value % 256)
            #if value == 256: value = 0
        #else:
            #value = value % 256

        if i % 16 == 15:
            comma = ""
        else:
            comma = ", "

        if i % 16 == 0:
            tables += "\n    .db "

        tables += str(value) + comma
    tables += "\n\n"

f = open('d11.multables.asm', 'w+')
f.write(tables)
f.write('\n')
f.close()
	
