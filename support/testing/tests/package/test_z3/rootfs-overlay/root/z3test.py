#! /usr/bin/env python3

import z3

x = z3.Real('x')
y = z3.Real('y')
z = z3.Real('z')
s = z3.Solver()

s.add(3 * x + 2 * y - z == 1)
s.add(2 * x - 2 * y + 4 * z == -2)
s.add(-x + y / 2 - z == 0)

check = s.check()
model = s.model()

print(check)
print(model)

assert check == z3.sat
assert model[x] == 1 and model[y] == -2 and model[z] == -2
