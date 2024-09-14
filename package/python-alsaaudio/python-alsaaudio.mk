################################################################################
#
# python-alsaaudio
#
################################################################################

PYTHON_ALSAAUDIO_VERSION = 0.11.0
PYTHON_ALSAAUDIO_SOURCE = pyalsaaudio-$(PYTHON_ALSAAUDIO_VERSION).tar.gz
PYTHON_ALSAAUDIO_SITE = https://files.pythonhosted.org/packages/21/a6/3d833079b030d449345e35ce0e2874e330d3612135734f07b9ceace25bcf
PYTHON_ALSAAUDIO_SETUP_TYPE = setuptools
PYTHON_ALSAAUDIO_LICENSE = Python-2.0
PYTHON_ALSAAUDIO_LICENSE_FILES = LICENSE
PYTHON_ALSAAUDIO_DEPENDENCIES = alsa-lib

$(eval $(python-package))
