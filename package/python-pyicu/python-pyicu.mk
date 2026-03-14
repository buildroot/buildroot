################################################################################
#
# python-pyicu
#
################################################################################

PYTHON_PYICU_VERSION = 2.16.1
PYTHON_PYICU_SOURCE = pyicu-$(PYTHON_PYICU_VERSION).tar.gz
PYTHON_PYICU_SITE = https://files.pythonhosted.org/packages/51/a9/b68d8fad5b830146c42f08b444c716ec50f576cbc8f01e26f4da6e89fc7a
PYTHON_PYICU_LICENSE = MIT
PYTHON_PYICU_LICENSE_FILES = LICENSE
PYTHON_PYICU_DEPENDENCIES = icu
PYTHON_PYICU_SETUP_TYPE = setuptools

PYTHON_PYICU_ENV += \
	ICU_VERSION="`$(PKG_CONFIG_HOST_BINARY) icu-i18n --modversion`" \
	PYICU_CFLAGS="`$(PKG_CONFIG_HOST_BINARY) icu-i18n --variable=CXXFLAGS`" \
	PYICU_LFLAGS="`$(PKG_CONFIG_HOST_BINARY) icu-i18n --libs-only-L` \
		`$(PKG_CONFIG_HOST_BINARY) icu-i18n --libs-only-l`"

$(eval $(python-package))
