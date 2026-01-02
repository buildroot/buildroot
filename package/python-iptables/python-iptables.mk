################################################################################
#
# python-iptables
#
################################################################################

PYTHON_IPTABLES_VERSION = 1.2.0
PYTHON_IPTABLES_SOURCE = python_iptables-$(PYTHON_IPTABLES_VERSION).tar.gz
PYTHON_IPTABLES_SITE = https://files.pythonhosted.org/packages/55/3c/a2626b88fffb5bcebae80a2dca1e09ff539ab454a8e5fb2e50141943a1f8
PYTHON_IPTABLES_SETUP_TYPE = setuptools
PYTHON_IPTABLES_LICENSE = Apache-2.0
PYTHON_IPTABLES_LICENSE_FILES = NOTICE
PYTHON_IPTABLES_DEPENDENCIES = iptables

define PYTHON_IPTABLES_SET_XTABLES_ENV_VARS
	XTABLES_VERSION=`awk '/XTABLES_VERSION_CODE/ {print $$NF}' $(STAGING_DIR)/usr/include/xtables-version.h`; \
	sed -i "s%os.getenv(\"PYTHON_IPTABLES_XTABLES_VERSION\")%$$XTABLES_VERSION%" $(@D)/iptc/xtables.py
	sed -i "s%os.getenv(\"XTABLES_LIBDIR\")%\"/usr/lib/xtables\"%" $(@D)/iptc/xtables.py
	sed -i "s%os.environ.get('IPTABLES_LIBDIR', None)%\"/usr/lib\"%" $(@D)/iptc/util.py
endef

PYTHON_IPTABLES_PRE_BUILD_HOOKS += PYTHON_IPTABLES_SET_XTABLES_ENV_VARS

$(eval $(python-package))
