################################################################################
#
# python-pyasyncore
#
################################################################################

PYTHON_PYASYNCORE_VERSION = 1.0.4
PYTHON_PYASYNCORE_SOURCE = pyasyncore-$(PYTHON_PYASYNCORE_VERSION).tar.gz
PYTHON_PYASYNCORE_SITE = https://files.pythonhosted.org/packages/25/6e/956e2bc9b47e3310cd524036f506b779a77788c2a1eb732e544240ad346f
PYTHON_PYASYNCORE_SETUP_TYPE = setuptools
PYTHON_PYASYNCORE_LICENSE = PSF-2.0
PYTHON_PYASYNCORE_LICENSE_FILES = LICENSE

$(eval $(python-package))
