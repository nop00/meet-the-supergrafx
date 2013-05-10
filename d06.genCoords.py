import math

count = 128
origin = [128, 150]
asm = "bg00coords:"
asm2 = "bg01coords:"

for i in range(0, count):
    if i % 8 == 0:
        asm += "\n    .db "
        asm2 += "\n    .db "
    else:
        asm += ", "
        asm2 += ", "

    value = int(math.floor(origin[0] + math.sin((2 * math.pi) / 128 * i) * 8))
    asm += str(value) + ", "
    value = int(math.floor(origin[1] + math.sin((2 * math.pi) / 128 * i) * 10))
    asm += str(value)

    value = int(math.floor(origin[0] - math.sin((2 * math.pi) / 128 * i) * 10))
    asm2 += str(value) + ", "
    value = int(math.floor(origin[1] - math.cos((2 * math.pi) / 128 * i) * 10))
    asm2 += str(value)
 

asmfile = open("d06.coords.asm", 'w+')
asmfile.write(asm)
asmfile.write("\n\n")
asmfile.write(asm2)
asmfile.write("\n")
asmfile.close()


