################################################################################
#
# python-pymupdf
#
################################################################################

# python-pymupdf's version must match exactly mupdf's version
PYTHON_PYMUPDF_VERSION = 1.16.0
PYTHON_PYMUPDF_SOURCE = PyMuPDF-$(PYTHON_PYMUPDF_VERSION).tar.gz
PYTHON_PYMUPDF_SITE = https://files.pythonhosted.org/packages/d2/da/692102b6e6868a57d1dc7f98d07413116a02493b3b49a798dcd6f676d368
PYTHON_PYMUPDF_SETUP_TYPE = distutils
PYTHON_PYMUPDF_LICENSE = GPL-3.0, AGPL-3.0+ (code generated from mupdf)
# No license file included in pip, but it's present on github
PYTHON_PYMUPDF_DEPENDENCIES = mupdf zlib

PYTHON_PYMUPDF_ENV = CFLAGS="-I$(STAGING_DIR)/usr/include/mupdf"

# We need to remove the original paths as we provide them in the CFLAGS:
define PYTHON_PYMUPDF_REMOVE_PATHS
	sed -i "s:\/usr\/include\/mupdf::g" $(@D)/setup.py
	sed -i "s:\/usr\/local\/include\/mupdf::g" $(@D)/setup.py
endef

PYTHON_PYMUPDF_POST_PATCH_HOOKS = PYTHON_PYMUPDF_REMOVE_PATHS

$(eval $(python-package))
