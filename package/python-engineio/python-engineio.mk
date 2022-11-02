################################################################################
#
# python-engineio
#
################################################################################

PYTHON_ENGINEIO_VERSION = 4.3.4
PYTHON_ENGINEIO_SITE = https://files.pythonhosted.org/packages/7e/ff/970c5d084f513fb38108cd7c90497489d7cff8666f9bfabae00a3f4e13d4
PYTHON_ENGINEIO_SETUP_TYPE = setuptools
PYTHON_ENGINEIO_LICENSE = MIT
PYTHON_ENGINEIO_LICENSE_FILES = LICENSE
PYTHON_ENGINEIO_CPE_ID_VENDOR = python-engineio_project

$(eval $(python-package))
