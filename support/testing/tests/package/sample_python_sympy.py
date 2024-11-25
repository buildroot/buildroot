#! /usr/bin/env python3

from sympy import symbols, expand, factor

x, y = symbols('x y')

expr = x + 2*y

expanded_expr = expand(x*expr)
print(expanded_expr)
assert str(expanded_expr) == "x**2 + 2*x*y"

factored_expr = factor(expanded_expr)
print(factored_expr)
assert str(factored_expr) == "x*(x + 2*y)"
