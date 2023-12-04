################################################################################
#
# python-flit-core
#
################################################################################

PYTHON_FLIT_CORE_VERSION = 3.9.0
PYTHON_FLIT_CORE_SOURCE = flit_core-$(PYTHON_FLIT_CORE_VERSION).tar.gz
PYTHON_FLIT_CORE_SITE = https://files.pythonhosted.org/packages/c4/e6/c1ac50fe3eebb38a155155711e6e864e254ce4b6e17fe2429b4c4d5b9e80
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
