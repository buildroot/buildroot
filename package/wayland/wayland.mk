################################################################################
#
# wayland
#
################################################################################

WAYLAND_VERSION = 1.23.1
WAYLAND_SITE = https://gitlab.freedesktop.org/wayland/wayland/-/releases/$(WAYLAND_VERSION)/downloads
WAYLAND_SOURCE = wayland-$(WAYLAND_VERSION).tar.xz
WAYLAND_LICENSE = MIT
WAYLAND_LICENSE_FILES = COPYING
WAYLAND_CPE_ID_VENDOR = wayland
WAYLAND_INSTALL_STAGING = YES
WAYLAND_DEPENDENCIES = host-pkgconf host-wayland expat libffi libxml2
HOST_WAYLAND_DEPENDENCIES = host-pkgconf host-expat host-libffi host-libxml2

WAYLAND_CONF_OPTS = -Dtests=false -Ddocumentation=false
HOST_WAYLAND_CONF_OPTS = -Dtests=false -Ddocumentation=false

# Remove the DTD from the target, it's not needed at runtime
define WAYLAND_TARGET_CLEANUP
	rm -rf $(TARGET_DIR)/usr/share/wayland
endef
WAYLAND_POST_INSTALL_TARGET_HOOKS += WAYLAND_TARGET_CLEANUP

# The wayland-scanner.pc installed by the target wayland package is
# used to find the wayland-scanner tool, which in a cross-compilation
# context is compiled for the host (and in Buildroot, compiled by
# host-wayland). Below, we tweak the target wayland-scanner.pc so that
# when the wayland_scanner variable is requested through pkg-config,
# it points to the host wayland_scanner tool.
define WAYLAND_TWEAK_WAYLAND_SCANNER_PATH
	$(SED) 's%^wayland_scanner=.*%wayland_scanner=$(HOST_DIR)/bin/wayland-scanner%' \
		$(STAGING_DIR)/usr/lib/pkgconfig/wayland-scanner.pc
endef
WAYLAND_POST_INSTALL_TARGET_HOOKS += WAYLAND_TWEAK_WAYLAND_SCANNER_PATH

$(eval $(meson-package))
$(eval $(host-meson-package))
