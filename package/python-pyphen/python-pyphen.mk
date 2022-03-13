################################################################################
#
# python-pyphen
#
################################################################################

PYTHON_PYPHEN_VERSION = 0.12.0
PYTHON_PYPHEN_SOURCE = pyphen-$(PYTHON_PYPHEN_VERSION).tar.gz
PYTHON_PYPHEN_SITE = https://files.pythonhosted.org/packages/0e/21/9e0841aa76db69e2d74cd64ea2271151d7332fa627a5f03eb0d9ccf3da87
PYTHON_PYPHEN_SETUP_TYPE = flit
PYTHON_PYPHEN_LICENSE = LGPL-2.1+, MPL-1.1, GPL-2.0+
PYTHON_PYPHEN_LICENSE_FILES = LICENSE COPYING.GPL COPYING.LGPL COPYING.MPL

$(eval $(python-package))
