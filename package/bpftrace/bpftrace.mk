################################################################################
#
# bpftrace
#
################################################################################

BPFTRACE_VERSION = 0.26.1
BPFTRACE_SITE = $(call github,bpftrace,bpftrace,v$(BPFTRACE_VERSION))
BPFTRACE_LICENSE = Apache-2.0
BPFTRACE_LICENSE_FILES = LICENSE
BPFTRACE_DEPENDENCIES = \
	bcc \
	bzip2 \
	cereal \
	elfutils \
	host-vim \
	libbpf \
	llvm \
	xz

# libbfd, libopcodes
ifeq ($(BR2_PACKAGE_BINUTILS),y)
BPFTRACE_DEPENDENCIES += binutils
endif

BPFTRACE_CONF_OPTS += \
	-DBUILD_SHARED_LIBS:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -I$(STAGING_DIR)/usr/include/bpf" \
	-DENABLE_MAN:BOOL=OFF \
	-DUSE_SYSTEM_LIBBPF:BOOL=ON

$(eval $(cmake-package))
