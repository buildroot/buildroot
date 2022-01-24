################################################################################
#
# python-charset-normalizer
#
################################################################################

PYTHON_CHARSET_NORMALIZER_VERSION = 2.0.10
PYTHON_CHARSET_NORMALIZER_SOURCE = charset-normalizer-$(PYTHON_CHARSET_NORMALIZER_VERSION).tar.gz
PYTHON_CHARSET_NORMALIZER_SITE = https://files.pythonhosted.org/packages/48/44/76b179e0d1afe6e6a91fd5661c284f60238987f3b42b676d141d01cd5b97
PYTHON_CHARSET_NORMALIZER_SETUP_TYPE = setuptools
PYTHON_CHARSET_NORMALIZER_LICENSE = MIT
PYTHON_CHARSET_NORMALIZER_LICENSE_FILES = LICENSE
HOST_PYTHON_CHARSET_NORMALIZER_NEEDS_HOST_PYTHON = python3

$(eval $(python-package))
$(eval $(host-python-package))
