################################################################################
#
# k3conf
#
################################################################################

K3CONF_VERSION = v0.4
K3CONF_SITE = https://git.ti.com/git/k3conf/k3conf.git
K3CONF_SITE_METHOD = git
K3CONF_LICENSE = BSD-3-Clause
K3CONF_LICENSE_FILES = LICENSE

define K3CONF_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_DEVMEM)
endef

$(eval $(cmake-package))
