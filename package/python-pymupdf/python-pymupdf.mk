################################################################################
#
# python-pymupdf
#
################################################################################

# python-pymupdf's version must be compatible with mupdf's version
PYTHON_PYMUPDF_VERSION = 1.23.22
PYTHON_PYMUPDF_SOURCE = PyMuPDF-$(PYTHON_PYMUPDF_VERSION).tar.gz
PYTHON_PYMUPDF_SITE = https://files.pythonhosted.org/packages/05/20/a0d1221d8f379afcc12b4d1687a8f4adb69eef659e835d781c3fa331ff46
PYTHON_PYMUPDF_SETUP_TYPE = setuptools
PYTHON_PYMUPDF_LICENSE = AGPL-3.0+
PYTHON_PYMUPDF_LICENSE_FILES = COPYING
# No license file included in pip, but it's present on github
PYTHON_PYMUPDF_DEPENDENCIES = freetype host-swig mupdf
PYTHON_PYMUPDF_BUILD_OPTS = --skip-dependency-check

PYTHON_PYMUPDF_ENV = \
	PYMUPDF_INCLUDES="$(STAGING_DIR)/usr/include/freetype2:$(STAGING_DIR)/usr/include" \
	PYMUPDF_MUPDF_LIB="$(STAGING_DIR)/usr/lib" \
	PYMUPDF_PYTHON_CONFIG="$(STAGING_DIR)/usr/bin/python3-config" \
	PYMUPDF_SETUP_IMPLEMENTATIONS=a \
	PYMUPDF_SETUP_MUPDF_BUILD=

$(eval $(python-package))
