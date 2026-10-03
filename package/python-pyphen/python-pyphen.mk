################################################################################
#
# python-pyphen
#
################################################################################

PYTHON_PYPHEN_VERSION = 0.18.1
PYTHON_PYPHEN_SOURCE = pyphen-$(PYTHON_PYPHEN_VERSION).tar.gz
PYTHON_PYPHEN_SITE = https://files.pythonhosted.org/packages/94/47/8430452269cd28863d73b903d07d329d058cf762527ff211b3864ba61fc7
PYTHON_PYPHEN_SETUP_TYPE = flit
PYTHON_PYPHEN_LICENSE = LGPL-2.1+, MPL-1.1, GPL-2.0+
PYTHON_PYPHEN_LICENSE_FILES = LICENSE COPYING.GPL COPYING.LGPL COPYING.MPL

$(eval $(python-package))
