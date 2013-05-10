import math

asm = "plasmaLUT: .db "

for i in range(0, 256):
    #asm += str(int((1.0 + math.sin(i * (360.0 / 256.0) * 0.0174532)) / 2.0 * 64.0))
    asm += str(int((math.sin(i * (360.0 / 256.0) * 0.0174532)) * 64.0))
    if i % 16 != 15:
        asm += ", "
    elif i != 255:
        asm += "\n    .db "

asmfile = open("LUTs.asm", 'w+')
asmfile.write(asm)
asmfile.write("\n\n")
asmfile.close()


