################################################################################
#
# python-pycrate
#
################################################################################

PYTHON_PYCRATE_VERSION = 0.5.5
PYTHON_PYCRATE_SOURCE = pycrate-$(PYTHON_PYCRATE_VERSION).tar.gz
PYTHON_PYCRATE_SITE = https://files.pythonhosted.org/packages/25/8f/b3d7e0b541aa04b2f0f7aa694a6946b572bfa2e2627cf1f12b5416d633df
PYTHON_PYCRATE_SETUP_TYPE = setuptools
PYTHON_PYCRATE_EXTRA_DOWNLOADS = https://raw.githubusercontent.com/P1sec/pycrate/$(PYTHON_PYCRATE_VERSION)/license.txt
PYTHON_PYCRATE_LICENSE = LGPL-2.1+
PYTHON_PYCRATE_LICENSE_FILES = license.txt

define PYTHON_PYCRATE_ADD_LICENSE_FILE
	cp $(PYTHON_PYCRATE_DL_DIR)/license.txt $(@D)
endef
PYTHON_PYCRATE_POST_EXTRACT_HOOKS += PYTHON_PYCRATE_ADD_LICENSE_FILE

$(eval $(python-package))
