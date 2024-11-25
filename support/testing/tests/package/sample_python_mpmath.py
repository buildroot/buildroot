#! /usr/bin/env python3

# Test inspired from example published on the project page:
# https://mpmath.org/

from mpmath import mp

mp.dps = 50

result = mp.quad(lambda x: mp.exp(-x**2), [-mp.inf, mp.inf]) ** 2

# Pi digits can be cross-checked here:
# https://www.angio.net/pi/digits.html
expected_result = "3.1415926535897932384626433832795028841971693993751"

assert str(result) == expected_result
