################################################################################
#
# toolchain-buildroot
#
################################################################################

BR_LIBC = $(call qstrip,$(BR2_TOOLCHAIN_BUILDROOT_LIBC))

# Triggering the build of the gcc-final will automatically do the
# build of binutils, uClibc, kernel headers and all the intermediate
# gcc steps.

TOOLCHAIN_BUILDROOT_DEPENDENCIES = gcc-final

TOOLCHAIN_BUILDROOT_ADD_TOOLCHAIN_DEPENDENCY = NO

# Not really a virtual package, but we use the virtual package infra here so
# both the build log and build directory look nicer (toolchain-buildroot-virtual
# instead of toolchain-buildroot-undefined)
$(eval $(virtual-package))
