################################################################################
#
# python-mpd2
#
################################################################################

PYTHON_MPD2_VERSION = 3.1.0
PYTHON_MPD2_SITE = https://files.pythonhosted.org/packages/59/32/e57725251ce3117d2ed2a7b76d9722ea9bea26f54b2cc8981d03350e4103
PYTHON_MPD2_SETUP_TYPE = setuptools
PYTHON_MPD2_LICENSE = LGPL-3.0+
PYTHON_MPD2_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
