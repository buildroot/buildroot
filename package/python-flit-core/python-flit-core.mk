################################################################################
#
# python-flit-core
#
################################################################################

PYTHON_FLIT_CORE_VERSION = 3.8.0
PYTHON_FLIT_CORE_SOURCE = flit_core-$(PYTHON_FLIT_CORE_VERSION).tar.gz
PYTHON_FLIT_CORE_SITE = https://files.pythonhosted.org/packages/10/e5/be08751d07b30889af130cec20955c987a74380a10058e6e8856e4010afc
PYTHON_FLIT_CORE_LICENSE = BSD-3-Clause
PYTHON_FLIT_CORE_LICENSE_FILES = LICENSE
PYTHON_FLIT_CORE_SETUP_TYPE = flit-bootstrap

# Use flit built in bootstrap_install for installing host-python-flit-core.
# This is due to host-python-installer depending on host-python-flit-core.
#
HOST_PYTHON_FLIT_CORE_BASE_INSTALL_CMD = -m bootstrap_install dist/* $(HOST_PKG_PYTHON_PEP517_BOOTSTRAP_INSTALL_OPTS)

$(eval $(host-python-package))
