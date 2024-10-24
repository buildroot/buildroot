################################################################################
#
# python-pygments
#
################################################################################

PYTHON_PYGMENTS_VERSION = 2.18.0
PYTHON_PYGMENTS_SOURCE = pygments-$(PYTHON_PYGMENTS_VERSION).tar.gz
PYTHON_PYGMENTS_SITE = https://files.pythonhosted.org/packages/8e/62/8336eff65bcbc8e4cb5d05b55faf041285951b6e80f33e2bff2024788f31
PYTHON_PYGMENTS_LICENSE = BSD-2-Clause
PYTHON_PYGMENTS_LICENSE_FILES = LICENSE
PYTHON_PYGMENTS_CPE_ID_VENDOR = pygments
PYTHON_PYGMENTS_CPE_ID_PRODUCT = pygments
PYTHON_PYGMENTS_SETUP_TYPE = hatch

$(eval $(python-package))
