################################################################################
#
# python-flit-core
#
################################################################################

PYTHON_FLIT_CORE_VERSION = 3.12.0
PYTHON_FLIT_CORE_SOURCE = flit_core-$(PYTHON_FLIT_CORE_VERSION).tar.gz
PYTHON_FLIT_CORE_SITE = https://files.pythonhosted.org/packages/69/59/b6fc2188dfc7ea4f936cd12b49d707f66a1cb7a1d2c16172963534db741b
PYTHON_FLIT_CORE_LICENSE = BSD-3-Clause
PYTHON_FLIT_CORE_LICENSE_FILES = LICENSE
PYTHON_FLIT_CORE_SETUP_TYPE = flit-bootstrap

# Use flit built in bootstrap_install for installing host-python-flit-core.
# This is due to host-python-installer depending on host-python-flit-core.
define HOST_PYTHON_FLIT_CORE_INSTALL_CMDS
	cd $($(PKG)_BUILDDIR)/; \
		$(HOST_PKG_PYTHON_FLIT_BOOTSTRAP_ENV) \
		$(HOST_DIR)/bin/python3 \
		-m bootstrap_install dist/* \
		--installdir=$(HOST_DIR)/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages
endef

$(eval $(host-python-package))
