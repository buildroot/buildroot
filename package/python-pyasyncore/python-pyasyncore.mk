################################################################################
#
# python-pyasyncore
#
################################################################################

PYTHON_PYASYNCORE_VERSION = 1.0.4
PYTHON_PYASYNCORE_SOURCE = pyasyncore-$(PYTHON_PYASYNCORE_VERSION).tar.gz
PYTHON_PYASYNCORE_SITE = https://github.com/simonrob/pyasyncore/releases/download/v$(PYTHON_PYASYNCORE_VERSION)
PYTHON_PYASYNCORE_SETUP_TYPE = setuptools
PYTHON_PYASYNCORE_LICENSE = PSF-2.0
PYTHON_PYASYNCORE_LICENSE_FILES = LICENSE

$(eval $(python-package))
