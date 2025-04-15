################################################################################
#
# igh-ethercat
#
################################################################################

IGH_ETHERCAT_VERSION = 1.6.3
IGH_ETHERCAT_SITE = $(call gitlab,etherlab.org,ethercat,$(IGH_ETHERCAT_VERSION))
IGH_ETHERCAT_LICENSE = GPL-2.0 (IgH EtherCAT master), LGPL-2.1 (libraries)
IGH_ETHERCAT_LICENSE_FILES = COPYING COPYING.LESSER
# Fetching from Git
IGH_ETHERCAT_AUTORECONF = YES

IGH_ETHERCAT_INSTALL_STAGING = YES

IGH_ETHERCAT_CONF_OPTS = \
	--with-linux-dir=$(LINUX_DIR) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_USERLIB),--enable-userlib,--disable-userlib) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_CLITOOL),--enable-tool,--disable-tool) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_TTY),--enable-tty,--disable-tty) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_GENERIC),--enable-generic,--disable-generic) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_8139TOO),--enable-8139too,--disable-8139too) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_E100),--enable-e100,--disable-e100) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_E1000),--enable-e1000,--disable-e1000) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_E1000E),--enable-e1000e,--disable-e1000e) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_GENET),--enable-genet,--disable-genet) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_IGB),--enable-igb,--disable-igb) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_IGC),--enable-igc,--disable-igc) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_R8169),--enable-r8169,--disable-r8169) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_STMMAC_PCI),--enable-stmmac-pci,--disable-stmmac-pci) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_STMMAC),--enable-stmmac,--disable-stmmac) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_DWMAC_INTEL),--enable-dwmac-intel,--disable-dwmac-intel) \
	$(if $(BR2_PACKAGE_IGH_ETHERCAT_CCAT),--enable-ccat,--disable-ccat)

$(eval $(kernel-module))
$(eval $(autotools-package))
