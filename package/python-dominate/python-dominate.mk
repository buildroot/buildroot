################################################################################
#
# python-dominate
#
################################################################################

PYTHON_DOMINATE_VERSION = 3.1.0
PYTHON_DOMINATE_SOURCE = dominate-$(PYTHON_DOMINATE_VERSION).tar.gz
PYTHON_DOMINATE_SITE = https://files.pythonhosted.org/packages/4b/d4/35f08b4f459a44fff3295a70a46d6f8847b77945f059b0fac8d082efd9a9
PYTHON_DOMINATE_SETUP_TYPE = setuptools
PYTHON_DOMINATE_LICENSE = LGPL-3.0+
PYTHON_DOMINATE_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
