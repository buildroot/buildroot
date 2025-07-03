################################################################################
#
# python-future
#
################################################################################

PYTHON_FUTURE_VERSION = 1.0.0
PYTHON_FUTURE_SOURCE = future-$(PYTHON_FUTURE_VERSION).tar.gz
PYTHON_FUTURE_SITE = https://files.pythonhosted.org/packages/a7/b2/4140c69c6a66432916b26158687e821ba631a4c9273c474343badf84d3ba
PYTHON_FUTURE_SETUP_TYPE = setuptools
PYTHON_FUTURE_LICENSE = MIT
PYTHON_FUTURE_LICENSE_FILES = LICENSE.txt
PYTHON_FUTURE_CPE_ID_VENDOR = pythoncharmers

$(eval $(python-package))
