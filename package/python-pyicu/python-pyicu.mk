################################################################################
#
# python-pyicu
#
################################################################################

PYTHON_PYICU_VERSION = 2.11
PYTHON_PYICU_SOURCE = PyICU-$(PYTHON_PYICU_VERSION).tar.gz
PYTHON_PYICU_SITE = https://files.pythonhosted.org/packages/03/1b/800fce0236be0b8a99b3ccbb797786dd178028960b3fd65544e2d8bad5ac
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
