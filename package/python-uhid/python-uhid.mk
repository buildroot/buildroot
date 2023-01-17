################################################################################
#
# python-uhid
#
################################################################################

PYTHON_UHID_VERSION = 0.0.1
PYTHON_UHID_SOURCE = uhid-$(PYTHON_UHID_VERSION).tar.gz
PYTHON_UHID_SITE = https://files.pythonhosted.org/packages/cb/44/6ebe9dceadc028507d16603e2bb542557a4c70c6032ef8ee507c3ce51283
PYTHON_UHID_SETUP_TYPE = setuptools
PYTHON_UHID_LICENSE = MIT
PYTHON_UHID_LICENSE_FILES = LICENSE

define PYTHON_UHID_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_INPUT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_HID)
	$(call KCONFIG_ENABLE_OPT,CONFIG_UHID)
endef

$(eval $(python-package))
