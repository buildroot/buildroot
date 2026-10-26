################################################################################
#
# chawan
#
################################################################################

CHAWAN_VERSION = 0.5.1
CHAWAN_SITE = https://git.sr.ht/~bptato/chawan/archive
CHAWAN_SOURCE = v$(CHAWAN_VERSION).tar.gz
CHAWAN_LICENSE = Unlicense
CHAWAN_LICENSE_FILES = UNLICENSE

CHAWAN_DEPENDENCIES = brotli host-nim libssh2 openssl

ifeq ($(BR2_aarch64),y)
CHAWAN_TARGET_ARCH = arm64
else ifeq ($(BR2_i386),y)
CHAWAN_TARGET_ARCH = i386
else ifeq ($(BR2_powerpc64le),y)
CHAWAN_TARGET_ARCH = powerpc64el
else ifeq ($(BR2_x86_64),y)
CHAWAN_TARGET_ARCH = amd64
else
CHAWAN_TARGET_ARCH = $(BR2_ARCH)
endif

CHAWAN_MAKE_OPTS = \
	$(TARGET_CONFIGURE_OPTS) \
	FLAGS="--os=linux \
	--cpu:$(CHAWAN_TARGET_ARCH) \
	--gcc.exe:$(TARGET_CROSS)gcc \
	--gcc.linkerexe:$(TARGET_CROSS)gcc" \
	PREFIX="/usr"

# fixes a runtime issue: init.jsb is missing otherwise
CHAWAN_MAKE_OPTS += embed_startup=0

define CHAWAN_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(CHAWAN_MAKE_OPTS) -C $(@D) all
endef

define CHAWAN_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(CHAWAN_MAKE_OPTS) -C $(@D) \
		DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
