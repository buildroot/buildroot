################################################################################
#
# python-alsaaudio
#
################################################################################

PYTHON_ALSAAUDIO_VERSION = 0.10.0
PYTHON_ALSAAUDIO_SOURCE = pyalsaaudio-$(PYTHON_ALSAAUDIO_VERSION).tar.gz
PYTHON_ALSAAUDIO_SITE = https://files.pythonhosted.org/packages/e5/f0/411140b1c2d8eea8531233f39103e7ebda560030493e298be6439ce36936
PYTHON_ALSAAUDIO_SETUP_TYPE = setuptools
PYTHON_ALSAAUDIO_LICENSE = Python-2.0
PYTHON_ALSAAUDIO_LICENSE_FILES = LICENSE
PYTHON_ALSAAUDIO_DEPENDENCIES = alsa-lib

$(eval $(python-package))
