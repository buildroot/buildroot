################################################################################
#
# python-pyroute2
#
################################################################################

PYTHON_PYROUTE2_SITE = $(TOPDIR)/../thirdparty/pyroute2
PYTHON_PYROUTE2_SITE_METHOD = local

PYTHON_PYROUTE2_LICENSE = Apache-2.0 or GPL-2.0+
PYTHON_PYROUTE2_LICENSE_FILES = LICENSE.Apache.v2 LICENSE.GPL.v2 README.license.md

PYTHON_PYROUTE2_DEPENDENCIES = host-python3-pip

define PYTHON_PYROUTE2_BUILD_CMDS
	$(MAKE) python=$(HOST_DIR)/bin/python3 root=$(TARGET_DIR) -C $(@D) clean
	$(MAKE) python=$(HOST_DIR)/bin/python3 root=$(TARGET_DIR) -C $(@D) VERSION
	$(MAKE) python=$(HOST_DIR)/bin/python3 root=$(TARGET_DIR) -C $(@D) setup
	$(MAKE) python=$(HOST_DIR)/bin/python3 root=$(TARGET_DIR) -C $(@D) dist
endef

define PYTHON_PYROUTE2_INSTALL_TARGET_CMDS
	$(MAKE) python=$(HOST_DIR)/bin/python3 prefix=$(TARGET_DIR) -C $(@D) install
endef

$(eval $(generic-package))
