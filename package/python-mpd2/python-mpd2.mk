################################################################################
#
# python-mpd2
#
################################################################################

PYTHON_MPD2_VERSION = 3.1.1
PYTHON_MPD2_SITE = https://files.pythonhosted.org/packages/53/be/e77206eb35eb37ccd3506fba237e1431431d04c482707730ce2a6802e95c
PYTHON_MPD2_SETUP_TYPE = setuptools
PYTHON_MPD2_LICENSE = LGPL-3.0+
PYTHON_MPD2_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
