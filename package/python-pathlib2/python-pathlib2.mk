################################################################################
#
# python-pathlib2
#
################################################################################

PYTHON_PATHLIB2_VERSION = 2.3.6
PYTHON_PATHLIB2_SOURCE = pathlib2-$(PYTHON_PATHLIB2_VERSION).tar.gz
PYTHON_PATHLIB2_SITE = https://files.pythonhosted.org/packages/df/16/e9d6bcf1aed52a55bc1696324ab22586716053b3e97b85266e0f3ad36bae
PYTHON_PATHLIB2_LICENSE = MIT
PYTHON_PATHLIB2_LICENSE_FILES = LICENSE.rst
PYTHON_PATHLIB2_SETUP_TYPE = setuptools

$(eval $(python-package))
