################################################################################
#
# python-pyasyncore
#
################################################################################

PYTHON_PYASYNCORE_VERSION = 1.0.5
PYTHON_PYASYNCORE_SOURCE = pyasyncore-$(PYTHON_PYASYNCORE_VERSION).tar.gz
PYTHON_PYASYNCORE_SITE = https://files.pythonhosted.org/packages/4e/43/035dfe0cb01687c1940fdc008f46a43c41067e226e862df49327469764a0
PYTHON_PYASYNCORE_SETUP_TYPE = setuptools
PYTHON_PYASYNCORE_LICENSE = PSF-2.0
PYTHON_PYASYNCORE_LICENSE_FILES = LICENSE

$(eval $(python-package))
