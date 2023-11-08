################################################################################
#
# python-mbstrdecoder
#
################################################################################

PYTHON_MBSTRDECODER_VERSION = 1.1.3
PYTHON_MBSTRDECODER_SOURCE = mbstrdecoder-$(PYTHON_MBSTRDECODER_VERSION).tar.gz
PYTHON_MBSTRDECODER_SITE = https://files.pythonhosted.org/packages/70/8f/dd5d4efbe3f90d2d38c948f0ca5c698e2d6cedc58ead2f5b90272cbcb4fa
PYTHON_MBSTRDECODER_SETUP_TYPE = setuptools
PYTHON_MBSTRDECODER_LICENSE = MIT
PYTHON_MBSTRDECODER_LICENSE_FILES = LICENSE

$(eval $(python-package))
