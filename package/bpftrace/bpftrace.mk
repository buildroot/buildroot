################################################################################
#
# bpftrace
#
################################################################################

BPFTRACE_VERSION = 0.19.1
BPFTRACE_SITE = $(call github,iovisor,bpftrace,v$(BPFTRACE_VERSION))
BPFTRACE_LICENSE = Apache-2.0
BPFTRACE_LICENSE_FILES = LICENSE
BPFTRACE_DEPENDENCIES = \
	bcc \
	bzip2 \
	cereal \
	elfutils \
	host-bison \
	host-flex \
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
	-DENABLE_MAN:BOOL=OFF \
	-DINSTALL_TOOL_DOCS:BOOL=OFF \
	-DUSE_SYSTEM_BPF_BCC:BOOL=ON

$(eval $(cmake-package))
