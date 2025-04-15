################################################################################
#
# libffi
#
################################################################################

LIBFFI_VERSION = 3.4.8
LIBFFI_SITE = \
	https://github.com/libffi/libffi/releases/download/v$(LIBFFI_VERSION)
LIBFFI_LICENSE = MIT
LIBFFI_LICENSE_FILES = LICENSE
LIBFFI_CPE_ID_VALID = YES
LIBFFI_INSTALL_STAGING = YES
# We're patching configure.ac
LIBFFI_AUTORECONF = YES
LIBFFI_CONF_OPTS = --disable-multi-os-directory

# The static exec trampolines is enabled by default since
# libffi 3.4.2. However it doesn't work with gobject-introspection.
LIBFFI_CONF_OPTS += --disable-exec-static-tramp

$(eval $(autotools-package))
$(eval $(host-autotools-package))
