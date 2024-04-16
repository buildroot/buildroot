################################################################################
#
# python-iptables
#
################################################################################

PYTHON_IPTABLES_VERSION = 1.0.1
PYTHON_IPTABLES_SITE = https://files.pythonhosted.org/packages/35/e4/33e639b9e153c2d798d73342a96715a4edca6f46431d763b275a34b3aeca
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
