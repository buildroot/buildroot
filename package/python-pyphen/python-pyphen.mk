################################################################################
#
# python-pyphen
#
################################################################################

PYTHON_PYPHEN_VERSION = 0.17.0
PYTHON_PYPHEN_SOURCE = pyphen-$(PYTHON_PYPHEN_VERSION).tar.gz
PYTHON_PYPHEN_SITE = https://files.pythonhosted.org/packages/66/46/3dd0ae4b52016496069af6c4fca3b5918b0281fc92678f739edb8f3eb377
PYTHON_PYPHEN_SETUP_TYPE = flit
PYTHON_PYPHEN_LICENSE = LGPL-2.1+, MPL-1.1, GPL-2.0+
PYTHON_PYPHEN_LICENSE_FILES = LICENSE COPYING.GPL COPYING.LGPL COPYING.MPL

$(eval $(python-package))
