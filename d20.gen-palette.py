import math


# 36
nbColors = 256
palette = "rainbowpalette: "
comma = ", "

for i in range(0, nbColors):
    h = 360.0 * (i / float(nbColors)) / 60.0;
    x = int(math.floor((1.0 - abs(math.fmod(h, 2.0) - 1.0)) * 252.0 / 36.0));

    if i % 16 == 15:
        comma = ""
    else:
        comma = ", "

    if i % 16 == 0:
        palette += "\n    .dw "

    
    if h < 1.0:
        r = 7
        g = x
        b = 0
    elif h < 2.0:
        r = x
        g = 7
        b = 0
    elif h < 3.0:
        r = 0
        g = 7
        b = x
    elif h < 4.0:
        r = 0
        g = x
        b = 7
    elif h < 5.0:
        r = x
        g = 0
        b = 7
    elif h <= 6.0:
        r = 7
        g = 0
        b = x

    color = g << 6 | r << 3 | b
    palette += str(color) + comma

f = open('d20.rainbow-palette.asm', 'w+')
f.write(palette)
f.write('\n')
f.close()
#                float offset = mod(time / 8.0, 640.0) / 640.0;
#
#                float h = 360.0 * mod(vTextureCoord.s - offset, 1.0) /  60.0;
#                float x = 1.0 - abs(mod(h, 2.0) - 1.0);
#                vec4 colorbar;
#                if (h < 1.0)
#                    colorbar = vec4(1.0, x, 0.0, 1.0);
#                else if (h < 2.0)
#                    colorbar = vec4(x, 1.0, 0.0, 1.0);
#                else if (h < 3.0)
#                    colorbar = vec4(0.0, 1.0, x, 1.0);
#                else if (h < 4.0)
#                    colorbar = vec4(0.0, x, 1.0, 1.0);
#                else if (h < 5.0)
#                    colorbar = vec4(x, 0.0, 1.0, 1.0);
#                else if (h <= 6.0)
#                    colorbar = vec4(1.0, 0.0, x, 1.0);
#
#                gl_FragColor = vec4(colorbar.rgb, colorbarOpacity);
# 
