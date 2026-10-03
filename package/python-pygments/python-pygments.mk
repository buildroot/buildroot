################################################################################
#
# python-pygments
#
################################################################################

PYTHON_PYGMENTS_VERSION = 2.21.0
PYTHON_PYGMENTS_SOURCE = pygments-$(PYTHON_PYGMENTS_VERSION).tar.gz
PYTHON_PYGMENTS_SITE = https://files.pythonhosted.org/packages/49/2e/ced460408999b33da6b31b0021b0f37d329e202d4169aeb164493778f25b
PYTHON_PYGMENTS_LICENSE = BSD-2-Clause
PYTHON_PYGMENTS_LICENSE_FILES = LICENSE
PYTHON_PYGMENTS_CPE_ID_VENDOR = pygments
PYTHON_PYGMENTS_CPE_ID_PRODUCT = pygments
PYTHON_PYGMENTS_SETUP_TYPE = hatch

$(eval $(python-package))
