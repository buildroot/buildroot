################################################################################
#
# qemu
#
################################################################################

# When updating the version, check whether the list of supported targets
# needs to be updated.
QEMU_VERSION = 8.0.3
QEMU_SOURCE = qemu-$(QEMU_VERSION).tar.xz
QEMU_SITE = https://download.qemu.org
QEMU_LICENSE = GPL-2.0, LGPL-2.1, MIT, BSD-3-Clause, BSD-2-Clause, Others/BSD-1c
QEMU_LICENSE_FILES = COPYING COPYING.LIB
# NOTE: there is no top-level license file for non-(L)GPL licenses;
#       the non-(L)GPL license texts are specified in the affected
#       individual source files.
QEMU_CPE_ID_VENDOR = qemu

#-------------------------------------------------------------

# The build system is now partly based on Meson.
# However, building is still done with configure and make as in previous versions of QEMU.

# Target-qemu
QEMU_DEPENDENCIES = \
	host-meson \
	host-pkgconf \
	host-python3 \
	libglib2 \
	zlib

# Need the LIBS variable because librt and libm are
# not automatically pulled. :-(
QEMU_LIBS = -lrt -lm

QEMU_OPTS =

QEMU_VARS = LIBTOOL=$(HOST_DIR)/bin/libtool

# If we want to build all emulation targets, we just need to either enable -user
# and/or -system emulation appropriately.
# Otherwise, if we want only a subset of targets, we must still enable all of
# them, so that QEMU properly builds a list of default targets from which it
# checks if the specified sub-set is valid.

ifeq ($(BR2_PACKAGE_QEMU_SYSTEM),y)
QEMU_DEPENDENCIES += pixman
QEMU_OPTS += --enable-system
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_AARCH64) += aarch64-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_ALPHA) += alpha-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_ARM) += arm-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_AVR) += avr-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_CRIS) += cris-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_HPPA) += hppa-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_I386) += i386-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_LOONGARCH64) += loongarch64-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_M68K) += m68k-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_MICROBLAZE) += microblaze-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_MICROBLAZEEL) += microblazeel-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_MIPS) += mips-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_MIPS64) += mips64-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_MIPS64EL) += mips64el-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_MIPSEL) += mipsel-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_NIOS2) += nios2-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_OR1K) += or1k-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_PPC) += ppc-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_PPC64) += ppc64-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_RISCV32) += riscv32-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_RISCV64) += riscv64-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_RX) += rx-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_S390X) += s390x-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_SH4) += sh4-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_SH4EB) += sh4eb-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_SPARC) += sparc-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_SPARC64) += sparc64-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_TRICORE) += tricore-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_X86_64) += x86_64-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_XTENSA) += xtensa-softmmu
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_XTENSAEB) += xtensaeb-softmmu
else
QEMU_OPTS += --disable-system
endif

ifeq ($(BR2_PACKAGE_QEMU_LINUX_USER),y)
QEMU_OPTS += --enable-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_AARCH64) += aarch64-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_AARCH64_BE) += aarch64_be-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_ALPHA) += alpha-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_ARM) += arm-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_ARMEB) += armeb-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_CRIS) += cris-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_HEXAGON) += hexagon-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_HPPA) += hppa-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_I386) += i386-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_LOONGARCH64) += loongarch64-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_M68K) += m68k-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_MICROBLAZE) += microblaze-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_MICROBLAZEEL) += microblazeel-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_MIPS) += mips-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_MIPS64) += mips64-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_MIPS64EL) += mips64el-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_MIPSEL) += mipsel-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_MIPSN32) += mipsn32-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_MIPSN32EL) += mipsn32el-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_NIOS2) += nios2-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_OR1K) += or1k-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_PPC) += ppc-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_PPC64) += ppc64-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_PPC64LE) += ppc64le-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_RISCV32) += riscv32-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_RISCV64) += riscv64-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_S390X) += s390x-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_SH4) += sh4-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_SH4EB) += sh4eb-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_SPARC) += sparc-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_SPARC32PLUS) += sparc32plus-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_SPARC64) += sparc64-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_X86_64) += x86_64-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_XTENSA) += xtensa-linux-user
QEMU_TARGET_LIST_$(BR2_PACKAGE_QEMU_TARGET_XTENSAEB) += xtensaeb-linux-user
else
QEMU_OPTS += --disable-linux-user
endif

# Build the list of desired targets, if any.
ifeq ($(BR2_PACKAGE_QEMU_CHOOSE_TARGETS),y)
QEMU_TARGET_LIST = $(strip $(QEMU_TARGET_LIST_y))
ifeq ($(BR_BUILDING).$(QEMU_TARGET_LIST),y.)
$(error "No emulator target has ben chosen")
endif
QEMU_OPTS += --target-list="$(QEMU_TARGET_LIST)"
endif

ifeq ($(BR2_TOOLCHAIN_USES_UCLIBC),y)
QEMU_OPTS += --disable-vhost-user
else
QEMU_OPTS += --enable-vhost-user
endif

ifeq ($(BR2_PACKAGE_QEMU_SLIRP),y)
QEMU_OPTS += --enable-slirp
QEMU_DEPENDENCIES += slirp
else
QEMU_OPTS += --disable-slirp
endif

ifeq ($(BR2_PACKAGE_QEMU_SDL),y)
QEMU_OPTS += --enable-sdl
QEMU_DEPENDENCIES += sdl2
QEMU_VARS += SDL2_CONFIG=$(STAGING_DIR)/usr/bin/sdl2-config
else
QEMU_OPTS += --disable-sdl
endif

ifeq ($(BR2_PACKAGE_QEMU_FDT),y)
QEMU_OPTS += --enable-fdt
QEMU_DEPENDENCIES += dtc
else
QEMU_OPTS += --disable-fdt
endif

ifeq ($(BR2_PACKAGE_QEMU_TOOLS),y)
QEMU_OPTS += --enable-tools
else
QEMU_OPTS += --disable-tools
endif

ifeq ($(BR2_PACKAGE_QEMU_GUEST_AGENT),y)
QEMU_OPTS += --enable-guest-agent
else
QEMU_OPTS += --disable-guest-agent
endif

ifeq ($(BR2_PACKAGE_LIBFUSE3),y)
QEMU_OPTS += --enable-fuse --enable-fuse-lseek
QEMU_DEPENDENCIES += libfuse3
else
QEMU_OPTS += --disable-fuse --disable-fuse-lseek
endif

ifeq ($(BR2_PACKAGE_LIBSECCOMP),y)
QEMU_OPTS += --enable-seccomp
QEMU_DEPENDENCIES += libseccomp
else
QEMU_OPTS += --disable-seccomp
endif

ifeq ($(BR2_PACKAGE_LIBSSH),y)
QEMU_OPTS += --enable-libssh
QEMU_DEPENDENCIES += libssh
else
QEMU_OPTS += --disable-libssh
endif

ifeq ($(BR2_PACKAGE_LIBUSB),y)
QEMU_OPTS += --enable-libusb
QEMU_DEPENDENCIES += libusb
else
QEMU_OPTS += --disable-libusb
endif

ifeq ($(BR2_PACKAGE_LIBVNCSERVER),y)
QEMU_OPTS += \
	--enable-vnc \
	--disable-vnc-sasl
QEMU_DEPENDENCIES += libvncserver
ifeq ($(BR2_PACKAGE_LIBPNG),y)
QEMU_OPTS += --enable-png
QEMU_DEPENDENCIES += libpng
else
QEMU_OPTS += --disable-png
endif
ifeq ($(BR2_PACKAGE_JPEG),y)
QEMU_OPTS += --enable-vnc-jpeg
QEMU_DEPENDENCIES += jpeg
else
QEMU_OPTS += --disable-vnc-jpeg
endif
else
QEMU_OPTS += --disable-vnc
endif

ifeq ($(BR2_PACKAGE_NETTLE),y)
QEMU_OPTS += --enable-nettle
QEMU_DEPENDENCIES += nettle
else
QEMU_OPTS += --disable-nettle
endif

ifeq ($(BR2_PACKAGE_NUMACTL),y)
QEMU_OPTS += --enable-numa
QEMU_DEPENDENCIES += numactl
else
QEMU_OPTS += --disable-numa
endif

ifeq ($(BR2_PACKAGE_SPICE),y)
QEMU_OPTS += --enable-spice
QEMU_DEPENDENCIES += spice
else
QEMU_OPTS += --disable-spice
endif

ifeq ($(BR2_PACKAGE_USBREDIR),y)
QEMU_OPTS += --enable-usb-redir
QEMU_DEPENDENCIES += usbredir
else
QEMU_OPTS += --disable-usb-redir
endif

ifeq ($(BR2_STATIC_LIBS),y)
QEMU_OPTS += --static
endif

ifeq ($(BR2_PACKAGE_QEMU_BLOBS),y)
QEMU_OPTS += --enable-install-blobs
else
QEMU_OPTS += --disable-install-blobs
endif

# Override CPP, as it expects to be able to call it like it'd
# call the compiler.
define QEMU_CONFIGURE_CMDS
	unset TARGET_DIR; \
	cd $(@D); \
		LIBS='$(QEMU_LIBS)' \
		$(TARGET_CONFIGURE_OPTS) \
		$(TARGET_CONFIGURE_ARGS) \
		CPP="$(TARGET_CC) -E" \
		$(QEMU_VARS) \
		./configure \
			--prefix=/usr \
			--cross-prefix=$(TARGET_CROSS) \
			--audio-drv-list= \
			--meson=$(HOST_DIR)/bin/meson \
			--ninja=$(HOST_DIR)/bin/ninja \
			--disable-alsa \
			--disable-bpf \
			--disable-brlapi \
			--disable-bsd-user \
			--disable-cap-ng \
			--disable-capstone \
			--disable-containers \
			--disable-coreaudio \
			--disable-curl \
			--disable-curses \
			--disable-dbus-display \
			--disable-docs \
			--disable-dsound \
			--disable-hvf \
			--disable-jack \
			--disable-libiscsi \
			--disable-linux-aio \
			--disable-linux-io-uring \
			--disable-malloc-trim \
			--disable-membarrier \
			--disable-mpath \
			--disable-netmap \
			--disable-opengl \
			--disable-oss \
			--disable-pa \
			--disable-rbd \
			--disable-sanitizers \
			--disable-selinux \
			--disable-sparse \
			--disable-strip \
			--disable-vde \
			--disable-vhost-crypto \
			--disable-vhost-user-blk-server \
			--disable-virtfs \
			--disable-whpx \
			--disable-xen \
			--enable-attr \
			--enable-kvm \
			--enable-vhost-net \
			--with-git-submodules=ignore \
			--disable-hexagon-idef-parser \
			$(QEMU_OPTS)
endef

define QEMU_BUILD_CMDS
	unset TARGET_DIR; \
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QEMU_INSTALL_TARGET_CMDS
	unset TARGET_DIR; \
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(QEMU_MAKE_ENV) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))

#-------------------------------------------------------------
# Host-qemu

HOST_QEMU_DEPENDENCIES = \
	host-libglib2 \
	host-meson \
	host-pixman \
	host-pkgconf \
	host-python3 \
	host-slirp \
	host-zlib

#       BR ARCH         qemu
#       -------         ----
#       arm             arm
#       armeb           armeb
#       i486            i386
#       i586            i386
#       i686            i386
#       x86_64          x86_64
#       m68k            m68k
#       microblaze      microblaze
#       mips            mips
#       mipsel          mipsel
#       mips64          mips64
#       mips64el        mips64el
#       nios2           nios2
#       or1k            or1k
#       powerpc         ppc
#       powerpc64       ppc64
#       powerpc64le     ppc64 (system) / ppc64le (usermode)
#       sh2a            not supported
#       sh4             sh4
#       sh4eb           sh4eb
#       sh4a            sh4
#       sh4aeb          sh4eb
#       sparc           sparc
#       sparc64         sparc64
#       xtensa          xtensa

HOST_QEMU_ARCH = $(ARCH)
ifeq ($(HOST_QEMU_ARCH),armeb)
HOST_QEMU_SYS_ARCH = arm
endif
ifeq ($(HOST_QEMU_ARCH),i486)
HOST_QEMU_ARCH = i386
endif
ifeq ($(HOST_QEMU_ARCH),i586)
HOST_QEMU_ARCH = i386
endif
ifeq ($(HOST_QEMU_ARCH),i686)
HOST_QEMU_ARCH = i386
endif
ifeq ($(HOST_QEMU_ARCH),powerpc)
HOST_QEMU_ARCH = ppc
endif
ifeq ($(HOST_QEMU_ARCH),powerpc64)
HOST_QEMU_ARCH = ppc64
endif
ifeq ($(HOST_QEMU_ARCH),powerpc64le)
HOST_QEMU_ARCH = ppc64le
HOST_QEMU_SYS_ARCH = ppc64
endif
ifeq ($(HOST_QEMU_ARCH),sh4a)
HOST_QEMU_ARCH = sh4
endif
ifeq ($(HOST_QEMU_ARCH),sh4aeb)
HOST_QEMU_ARCH = sh4eb
endif
HOST_QEMU_SYS_ARCH ?= $(HOST_QEMU_ARCH)

HOST_QEMU_CFLAGS = $(HOST_CFLAGS)

ifeq ($(BR2_PACKAGE_HOST_QEMU_SYSTEM_MODE),y)
HOST_QEMU_TARGETS += $(HOST_QEMU_SYS_ARCH)-softmmu
HOST_QEMU_OPTS += --enable-system --enable-fdt
HOST_QEMU_CFLAGS += -I$(HOST_DIR)/include/libfdt
HOST_QEMU_DEPENDENCIES += host-dtc
else
HOST_QEMU_OPTS += --disable-system
endif

ifeq ($(BR2_PACKAGE_HOST_QEMU_LINUX_USER_MODE),y)
HOST_QEMU_TARGETS += $(HOST_QEMU_ARCH)-linux-user
HOST_QEMU_OPTS += --enable-linux-user

HOST_QEMU_HOST_SYSTEM_TYPE = $(shell uname -s)
ifneq ($(HOST_QEMU_HOST_SYSTEM_TYPE),Linux)
$(error "qemu-user can only be used on Linux hosts")
endif

else # BR2_PACKAGE_HOST_QEMU_LINUX_USER_MODE
HOST_QEMU_OPTS += --disable-linux-user
endif # BR2_PACKAGE_HOST_QEMU_LINUX_USER_MODE

ifeq ($(BR2_PACKAGE_HOST_QEMU_VDE2),y)
HOST_QEMU_OPTS += --enable-vde
HOST_QEMU_DEPENDENCIES += host-vde2
endif

# virtfs-proxy-helper is the only user of libcap-ng.
ifeq ($(BR2_PACKAGE_HOST_QEMU_VIRTFS),y)
HOST_QEMU_OPTS += --enable-virtfs --enable-cap-ng
HOST_QEMU_DEPENDENCIES += host-libcap-ng
else
HOST_QEMU_OPTS += --disable-virtfs --disable-cap-ng
endif

ifeq ($(BR2_PACKAGE_HOST_QEMU_USB),y)
HOST_QEMU_OPTS += --enable-libusb
HOST_QEMU_DEPENDENCIES += host-libusb
else
HOST_QEMU_OPTS += --disable-libusb
endif

# Override CPP, as it expects to be able to call it like it'd
# call the compiler.
define HOST_QEMU_CONFIGURE_CMDS
	unset TARGET_DIR; \
	cd $(@D); $(HOST_CONFIGURE_OPTS) CPP="$(HOSTCC) -E" \
		./configure \
		--target-list="$(HOST_QEMU_TARGETS)" \
		--prefix="$(HOST_DIR)" \
		--interp-prefix=$(STAGING_DIR) \
		--cc="$(HOSTCC)" \
		--host-cc="$(HOSTCC)" \
		--extra-cflags="$(HOST_QEMU_CFLAGS)" \
		--extra-ldflags="$(HOST_LDFLAGS)" \
		--meson=$(HOST_DIR)/bin/meson \
		--ninja=$(HOST_DIR)/bin/ninja \
		--disable-alsa \
		--disable-bpf \
		--disable-bzip2 \
		--disable-containers \
		--disable-coreaudio \
		--disable-curl \
		--disable-dbus-display \
		--disable-docs \
		--disable-dsound \
		--disable-jack \
		--disable-libssh \
		--disable-linux-aio \
		--disable-linux-io-uring \
		--disable-netmap \
		--disable-oss \
		--disable-pa \
		--disable-sdl \
		--disable-selinux \
		--disable-vde \
		--disable-vhost-user-blk-server \
		--disable-vnc-jpeg \
		--disable-png \
		--disable-vnc-sasl \
		--enable-slirp \
		--enable-tools \
		--disable-guest-agent \
		$(HOST_QEMU_OPTS)
endef

define HOST_QEMU_BUILD_CMDS
	unset TARGET_DIR; \
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D)
endef

define HOST_QEMU_INSTALL_CMDS
	unset TARGET_DIR; \
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) install
endef

# install symlink to qemu-system
ifeq ($(BR2_PACKAGE_HOST_QEMU_SYSTEM_MODE),y)
define HOST_QEMU_POST_INSTALL_SYMLINK
	ln -sf ./qemu-system-$(HOST_QEMU_ARCH) $(HOST_DIR)/bin/qemu-system
endef
HOST_QEMU_POST_INSTALL_HOOKS += HOST_QEMU_POST_INSTALL_SYMLINK
endif

$(eval $(host-generic-package))

# variable used by other packages
QEMU_USER = $(HOST_DIR)/bin/qemu-$(HOST_QEMU_ARCH)
