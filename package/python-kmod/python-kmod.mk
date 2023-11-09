################################################################################
#
# python-kmod
#
################################################################################

# The python-kmod package listed at https://pypi.org/project/kmod/#description
# is not the same as the one listed below.
PYTHON_KMOD_VERSION = 0.9.2
PYTHON_KMOD_SITE = $(call github,maurizio-lombardi,python-kmod,v$(PYTHON_KMOD_VERSION))
PYTHON_KMOD_SETUP_TYPE = setuptools
PYTHON_KMOD_LICENSE = LGPL-2.1
PYTHON_KMOD_LICENSE_FILES = COPYING.LESSER
PYTHON_KMOD_DEPENDENCIES = host-python-cython kmod

$(eval $(python-package))
