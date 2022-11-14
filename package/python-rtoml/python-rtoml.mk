################################################################################
#
# python-rtoml
#
################################################################################

PYTHON_RTOML_VERSION = 0.8.0
PYTHON_RTOML_SOURCE = rtoml-$(PYTHON_RTOML_VERSION).tar.gz
PYTHON_RTOML_SITE = https://files.pythonhosted.org/packages/33/a6/b42d8e0e28bec9fd7fdbafb2d76db3f8578f151a669eba564d422756d909
PYTHON_RTOML_SETUP_TYPE = setuptools
PYTHON_RTOML_LICENSE = MIT
PYTHON_RTOML_LICENSE_FILES = LICENSE
PYTHON_RTOML_DEPENDENCIES = host-python-setuptools-rust host-rustc
PYTHON_RTOML_ENV = \
	$(PKG_CARGO_ENV) \
	PYO3_CROSS_LIB_DIR="$(STAGING_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)"
# We need to vendor the Cargo crates at download time
PYTHON_RTOML_DOWNLOAD_POST_PROCESS = cargo
PYTHON_RTOML_DOWNLOAD_DEPENDENCIES = host-rustc
PYTHON_RTOML_DL_ENV = $(PKG_CARGO_ENV)

$(eval $(python-package))
