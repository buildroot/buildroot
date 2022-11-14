################################################################################
#
# python-mbstrdecoder
#
################################################################################

PYTHON_MBSTRDECODER_VERSION = 1.1.0
PYTHON_MBSTRDECODER_SOURCE = mbstrdecoder-$(PYTHON_MBSTRDECODER_VERSION).tar.gz
PYTHON_MBSTRDECODER_SITE = https://files.pythonhosted.org/packages/6c/10/f82ba5a91489c91bf6adaa0e1aca38a7ab2d1d7d80195a5f6ad8c2ff387a
PYTHON_MBSTRDECODER_SETUP_TYPE = setuptools
PYTHON_MBSTRDECODER_LICENSE = MIT
PYTHON_MBSTRDECODER_LICENSE_FILES = LICENSE

$(eval $(python-package))
