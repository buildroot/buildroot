################################################################################
#
# python-pyphen
#
################################################################################

PYTHON_PYPHEN_VERSION = 0.16.0
PYTHON_PYPHEN_SOURCE = pyphen-$(PYTHON_PYPHEN_VERSION).tar.gz
PYTHON_PYPHEN_SITE = https://files.pythonhosted.org/packages/33/87/493fc9e2597923a2b02a1facc376a3bf8e682698ae177b340c0c5fd1fdec
PYTHON_PYPHEN_SETUP_TYPE = flit
PYTHON_PYPHEN_LICENSE = LGPL-2.1+, MPL-1.1, GPL-2.0+
PYTHON_PYPHEN_LICENSE_FILES = LICENSE COPYING.GPL COPYING.LGPL COPYING.MPL

$(eval $(python-package))
