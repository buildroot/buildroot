################################################################################
#
# igh-ethercat
#
################################################################################

IGH_ETHERCAT_VERSION = 1.5.2
IGH_ETHERCAT_SITE = http://etherlab.org/download/ethercat
IGH_ETHERCAT_SOURCE = ethercat-$(IGH_ETHERCAT_VERSION).tar.bz2
IGH_ETHERCAT_LICENSE = GPL-2.0 (IgH EtherCAT master), LGPL-2.1 (libraries)
IGH_ETHERCAT_LICENSE_FILES = COPYING COPYING.LESSER

IGH_ETHERCAT_INSTALL_STAGING = YES

IGH_ETHERCAT_CONF_OPTS = \
	--with-linux-dir=$(LINUX_DIR) \
	$(if $(BR2_INSTALL_LIBSTDCPP),--enable-tool,--disable-tool) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_8139TOO),--enable-8139too,--disable-8139too) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_E100),--enable-e100,--disable-e100) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_E1000),--enable-e1000,--disable-e1000) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_E1000E),--enable-e1000e,--disable-e1000e) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_R8169),--enable-r8169,--disable-r8169)

$(eval $(kernel-module))
$(eval $(autotools-package))
