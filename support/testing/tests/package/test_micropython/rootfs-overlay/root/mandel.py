#! /usr/bin/env micropython

from micropython import mem_info

POINTS = list(",.:-;!/>)|&IH%*Z")


def mandel():
    for y in range(-15, 16):
        for x in range(1, 85):
            i = 0
            r = 0
            for k in range(112):
                j = (r*r) - (i*i) - 2 + (x/25)
                i = 2 * r * i + (y/10)
                if j*j + i*i >= 11:
                    break
                r = j
            print(POINTS[k & 0xF], end='')
        print()


if __name__ == '__main__':
    mandel()
    mem_info()
