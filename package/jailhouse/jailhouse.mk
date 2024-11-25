################################################################################
#
# jailhouse
#
################################################################################

JAILHOUSE_VERSION = e57d1eff6d55aeed5f977fe4e2acfb6ccbdd7560
JAILHOUSE_SITE = $(call github,siemens,jailhouse,$(JAILHOUSE_VERSION))
JAILHOUSE_LICENSE = GPL-2.0
JAILHOUSE_LICENSE_FILES = COPYING
JAILHOUSE_DEPENDENCIES = \
	linux

JAILHOUSE_MAKE_OPTS = \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	ARCH="$(KERNEL_ARCH)" \
	KDIR="$(LINUX_DIR)" \
	DESTDIR="$(TARGET_DIR)" \
	prefix=/usr

ifeq ($(BR2_PACKAGE_JAILHOUSE_HELPER_SCRIPTS),y)
JAILHOUSE_DEPENDENCIES += \
	host-python-mako \
	host-python-setuptools \
	python3
JAILHOUSE_MAKE_OPTS += \
	HAS_PYTHON_MAKO="yes" \
	PYTHON_PIP_USABLE="yes"
else
JAILHOUSE_MAKE_OPTS += \
	HAS_PYTHON_MAKO="no" \
	PYTHON_PIP_USABLE="no"
endif

ifeq ($(BR2_PACKAGE_JAILHOUSE_HELPER_SCRIPTS),y)
define JAILHOUSE_BUILD_HELPER_SCRIPTS
	cd $(@D) && \
	$(PKG_PYTHON_SETUPTOOLS_ENV) \
	$(HOST_DIR)/bin/python setup.py \
		build
endef
define JAILHOUSE_INSTALL_HELPER_SCRIPTS
	cd $(@D) && \
	$(PKG_PYTHON_SETUPTOOLS_ENV) \
	$(HOST_DIR)/bin/python setup.py \
		install --no-compile \
		$(PKG_PYTHON_SETUPTOOLS_INSTALL_OPTS) \
		--root=$(TARGET_DIR)
endef
endif

define JAILHOUSE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(JAILHOUSE_MAKE_OPTS) -C $(@D)

	$(JAILHOUSE_BUILD_HELPER_SCRIPTS)
endef

define JAILHOUSE_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(JAILHOUSE_MAKE_OPTS) -C $(@D) modules_install firmware_install tool_inmates_install
	$(TARGET_MAKE_ENV) $(MAKE) $(JAILHOUSE_MAKE_OPTS) -C $(@D)/tools src=$(@D)/tools install

	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/jailhouse
	$(INSTALL) -D -m 0644 $(@D)/configs/*/*.cell $(TARGET_DIR)/etc/jailhouse

	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/libexec/jailhouse/demos
	$(INSTALL) -D -m 0755 $(@D)/inmates/demos/*/*.bin $(TARGET_DIR)/usr/libexec/jailhouse/demos

	$(JAILHOUSE_INSTALL_HELPER_SCRIPTS)
endef

$(eval $(generic-package))
