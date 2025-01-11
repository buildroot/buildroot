################################################################################
#
# python-pygments
#
################################################################################

PYTHON_PYGMENTS_VERSION = 2.19.1
PYTHON_PYGMENTS_SOURCE = pygments-$(PYTHON_PYGMENTS_VERSION).tar.gz
PYTHON_PYGMENTS_SITE = https://files.pythonhosted.org/packages/7c/2d/c3338d48ea6cc0feb8446d8e6937e1408088a72a39937982cc6111d17f84
PYTHON_PYGMENTS_LICENSE = BSD-2-Clause
PYTHON_PYGMENTS_LICENSE_FILES = LICENSE
PYTHON_PYGMENTS_CPE_ID_VENDOR = pygments
PYTHON_PYGMENTS_CPE_ID_PRODUCT = pygments
PYTHON_PYGMENTS_SETUP_TYPE = hatch

$(eval $(python-package))
