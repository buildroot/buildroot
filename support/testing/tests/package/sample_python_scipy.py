import numpy
import scipy.io
import scipy.special
import scipy.integrate

cb = scipy.special.cbrt([27, 64])
assert((cb == numpy.array([3., 4.])).all())

com = scipy.special.comb(5, 2, exact = False, repetition=True)
assert(com == 15.0)

t = scipy.integrate.trapezoid([5,8,10])
assert(t == 15.5)

mdic = {"t": t, "label": "example"}
scipy.io.savemat("example.mat", mdic)
