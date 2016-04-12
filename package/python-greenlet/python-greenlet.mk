################################################################################
#
# python-greenlet
#
################################################################################

PYTHON_GREENLET_VERSION = 0.4.9
PYTHON_GREENLET_SOURCE = greenlet-$(PYTHON_GREENLET_VERSION).tar.gz
PYTHON_GREENLET_SITE = https://pypi.python.org/packages/source/g/greenlet
PYTHON_GREENLET_LICENSE = MIT License
PYTHON_GREENLET_LICENSE_FILES = LICENSE.txt
PYTHON_GREENLET_SETUP_TYPE = distutils

$(eval $(python-package))
