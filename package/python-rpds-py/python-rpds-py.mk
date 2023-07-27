################################################################################
#
# python-rpds-py
#
################################################################################

PYTHON_RPDS_PY_VERSION = 0.9.2
PYTHON_RPDS_PY_SOURCE = rpds_py-$(PYTHON_RPDS_PY_VERSION).tar.gz
PYTHON_RPDS_PY_SITE = https://files.pythonhosted.org/packages/da/3c/fa2701bfc5d67f4a23f1f0f4347284c51801e9dbc24f916231c2446647df
PYTHON_RPDS_PY_SETUP_TYPE = pep517
PYTHON_RPDS_PY_LICENSE = MIT
PYTHON_RPDS_PY_LICENSE_FILES = LICENSE
PYTHON_RPDS_PY_DEPENDENCIES = host-python-maturin
PYTHON_RPDS_PY_ENV = \
	$(PKG_CARGO_ENV) \
	PYO3_CROSS_LIB_DIR="$(STAGING_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)"
# We need to vendor the Cargo crates at download time
PYTHON_RPDS_PY_DOWNLOAD_POST_PROCESS = cargo
PYTHON_RPDS_PY_DOWNLOAD_DEPENDENCIES = host-rustc
PYTHON_RPDS_PY_DL_ENV = $(PKG_CARGO_ENV)

$(eval $(python-package))
