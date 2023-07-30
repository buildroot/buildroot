################################################################################
#
# libuv
#
################################################################################

# When bumping libuv, check if a new version of uvw is available
# and bump it too.
LIBUV_VERSION = 1.46.0
LIBUV_SOURCE = libuv-v$(LIBUV_VERSION)-dist.tar.gz
LIBUV_SITE = https://dist.libuv.org/dist/v$(LIBUV_VERSION)
LIBUV_DEPENDENCIES = host-pkgconf
LIBUV_INSTALL_STAGING = YES
LIBUV_LICENSE = BSD-2-Clause, BSD-3-Clause, ISC, MIT
LIBUV_LICENSE_FILES = LICENSE LICENSE-extra
LIBUV_CPE_ID_VENDOR = libuv

$(eval $(autotools-package))
