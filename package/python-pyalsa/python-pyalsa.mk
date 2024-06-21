################################################################################
#
# python-pyalsa
#
################################################################################

PYTHON_PYALSA_VERSION = 1.2.12
PYTHON_PYALSA_SOURCE = pyalsa-$(PYTHON_PYALSA_VERSION).tar.bz2
PYTHON_PYALSA_SITE = https://www.alsa-project.org/files/pub/pyalsa
PYTHON_PYALSA_SETUP_TYPE = setuptools
PYTHON_PYALSA_LICENSE = LGPL-2.1+
PYTHON_PYALSA_DEPENDENCIES = alsa-lib

$(eval $(python-package))
