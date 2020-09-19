################################################################################
#
# makedumpfile
#
################################################################################

MAKEDUMPFILE_VERSION = 1.6.7
MAKEDUMPFILE_SITE = $(call github,makedumpfile,makedumpfile,Released-$(subst .,-,$(MAKEDUMPFILE_VERSION)))
MAKEDUMPFILE_DEPENDENCIES = bzip2 elfutils xz zlib
MAKEDUMPFILE_LICENSE = GPL-2.0
MAKEDUMPFILE_LICENSE_FILES = COPYING

ifeq ($(BR2_PACKAGE_LZO),y)
MAKEDUMPFILE_DEPENDENCIES += lzo
MAKEDUMPFILE_MAKE_OPTS += USELZO=on
endif

ifeq ($(BR2_powerpc),y)
MAKEDUMPFILE_TARGET = powerpc32
else
MAKEDUMPFILE_TARGET = $(BR2_ARCH)
endif

define MAKEDUMPFILE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		$(MAKEDUMPFILE_MAKE_OPTS) TARGET=$(MAKEDUMPFILE_TARGET) LINKTYPE=dynamic
endef

define MAKEDUMPFILE_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) install \
		DESTDIR="$(TARGET_DIR)"
endef

$(eval $(generic-package))
