#! /usr/bin/env python3

# Tests inspired from commands published on project page:
# https://pypi.org/project/ml-dtypes/

from ml_dtypes import bfloat16

import numpy as np

a = np.zeros(4, dtype=bfloat16)
assert a.dtype.name == 'bfloat16'
assert a[0] == 0.0

types = [
    'bfloat16',
    'float8_e4m3b11fnuz',
    'float8_e4m3fn',
    'float8_e4m3fnuz',
    'float8_e5m2',
    'int4',
    'uint4'
]
for t in types:
    dtype = np.dtype(t)
    assert dtype.name == t

rng = np.random.default_rng(seed=0)
vals = rng.uniform(size=10000).astype(bfloat16)
sum_vals = vals.sum()
assert sum_vals == 256

b = bfloat16(256) + bfloat16(1)
assert b == 256

c = np.nextafter(bfloat16(256), bfloat16(np.inf))
assert c == 258

d = vals.sum(dtype='float32').astype(bfloat16)
assert d > 4500 and d < 5500
