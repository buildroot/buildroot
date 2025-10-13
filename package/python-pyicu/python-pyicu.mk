################################################################################
#
# python-pyicu
#
################################################################################

PYTHON_PYICU_VERSION = 2.15.3
PYTHON_PYICU_SOURCE = pyicu-$(PYTHON_PYICU_VERSION).tar.gz
PYTHON_PYICU_SITE = https://files.pythonhosted.org/packages/88/b0/c8b61bac55424e2ff80e20d7251c3f002baff3c07c34cee3849e3505d8f5
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
