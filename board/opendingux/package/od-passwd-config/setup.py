#!/usr/bin/env python

from distutils.core import Extension, setup
from Cython.Build import cythonize
from Cython.Distutils import build_ext

# define an extension that will be cythonized and compiled
ext = Extension(name='od_passwd_config', sources=['od-passwd-config.py'])
cmdclass = {'build_ext': build_ext}

setup(
        name = 'od_passwd_config',
        description = 'OpenDingux password configuration tool',
        cmdclass=cmdclass,
        ext_modules=cythonize(ext),
        py_modules=['od-passwd-config'],
)
