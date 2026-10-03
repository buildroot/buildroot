################################################################################
#
# python-charset-normalizer
#
################################################################################

PYTHON_CHARSET_NORMALIZER_VERSION = 3.5.1
PYTHON_CHARSET_NORMALIZER_SOURCE = charset_normalizer-$(PYTHON_CHARSET_NORMALIZER_VERSION).tar.gz
PYTHON_CHARSET_NORMALIZER_SITE = https://files.pythonhosted.org/packages/e5/3f/143b048436775b0f76ac3eec145c019e8173ccc2885c8f20319b996d5e83
PYTHON_CHARSET_NORMALIZER_SETUP_TYPE = setuptools
PYTHON_CHARSET_NORMALIZER_LICENSE = MIT
PYTHON_CHARSET_NORMALIZER_LICENSE_FILES = LICENSE
PYTHON_CHARSET_NORMALIZER_DEPENDENCIES = host-python-mypy
PYTHON_CHARSET_NORMALIZER_BUILD_OPTS = --skip-dependency-check
PYTHON_CHARSET_NORMALIZER_ENV = CHARSET_NORMALIZER_USE_MYPYC=1

$(eval $(python-package))
$(eval $(host-python-package))
