################################################################################
#
# python-kiwisolver
#
################################################################################

PYTHON_KIWISOLVER_VERSION = 1.4.9
PYTHON_KIWISOLVER_SOURCE = kiwisolver-$(PYTHON_KIWISOLVER_VERSION).tar.gz
PYTHON_KIWISOLVER_SITE = https://files.pythonhosted.org/packages/5c/3c/85844f1b0feb11ee581ac23fe5fce65cd049a200c1446708cc1b7f922875
PYTHON_KIWISOLVER_LICENSE = BSD-3-Clause
PYTHON_KIWISOLVER_LICENSE_FILES = LICENSE
PYTHON_KIWISOLVER_SETUP_TYPE = setuptools
PYTHON_KIWISOLVER_DEPENDENCIES = host-python-cppy host-python-setuptools-scm

$(eval $(python-package))
