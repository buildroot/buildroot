################################################################################
#
# python-charset-normalizer
#
################################################################################

PYTHON_CHARSET_NORMALIZER_VERSION = 2.0.11
PYTHON_CHARSET_NORMALIZER_SOURCE = charset-normalizer-$(PYTHON_CHARSET_NORMALIZER_VERSION).tar.gz
PYTHON_CHARSET_NORMALIZER_SITE = https://files.pythonhosted.org/packages/e8/e8/b6cfd28fb430b2ec9923ad0147025bf8bbdf304b1eb3039b69f1ce44ed6e
PYTHON_CHARSET_NORMALIZER_SETUP_TYPE = setuptools
PYTHON_CHARSET_NORMALIZER_LICENSE = MIT
PYTHON_CHARSET_NORMALIZER_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
