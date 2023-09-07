################################################################################
#
# python-dominate
#
################################################################################

PYTHON_DOMINATE_VERSION = 2.8.0
PYTHON_DOMINATE_SOURCE = dominate-$(PYTHON_DOMINATE_VERSION).tar.gz
PYTHON_DOMINATE_SITE = https://files.pythonhosted.org/packages/13/3d/8d22916c12184f0c4930b9cdfb136a130e8d8eacf5942fc9883f2a189f6a
PYTHON_DOMINATE_SETUP_TYPE = setuptools
PYTHON_DOMINATE_LICENSE = LGPL-3.0+
PYTHON_DOMINATE_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
