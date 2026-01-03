################################################################################
#
# python-engineio
#
################################################################################

PYTHON_ENGINEIO_VERSION = 4.13.0
PYTHON_ENGINEIO_SOURCE = python_engineio-$(PYTHON_ENGINEIO_VERSION).tar.gz
PYTHON_ENGINEIO_SITE = https://files.pythonhosted.org/packages/42/5a/349caac055e03ef9e56ed29fa304846063b1771ee54ab8132bf98b29491e
PYTHON_ENGINEIO_SETUP_TYPE = setuptools
PYTHON_ENGINEIO_LICENSE = MIT
PYTHON_ENGINEIO_LICENSE_FILES = LICENSE
PYTHON_ENGINEIO_CPE_ID_VALID = YES

$(eval $(python-package))
