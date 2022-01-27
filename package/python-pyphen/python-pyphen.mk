################################################################################
#
# python-pyphen
#
################################################################################

PYTHON_PYPHEN_VERSION = 0.11.0
PYTHON_PYPHEN_SOURCE = pyphen-$(PYTHON_PYPHEN_VERSION).tar.gz
PYTHON_PYPHEN_SITE = https://files.pythonhosted.org/packages/9a/f8/af869a4983c1b3159945479510260985714265d48baf27d61f72b1ec8cbf
PYTHON_PYPHEN_SETUP_TYPE = distutils
PYTHON_PYPHEN_LICENSE = LGPL-2.1+, MPL-1.1, GPL-2.0+
PYTHON_PYPHEN_LICENSE_FILES = LICENSE COPYING.GPL COPYING.LGPL COPYING.MPL

$(eval $(python-package))
