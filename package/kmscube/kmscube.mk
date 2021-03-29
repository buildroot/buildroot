################################################################################
#
# kmscube
#
################################################################################

ifneq ($(BR2_PACKAGE_RPI_FIRMWARE_VARIANT_PI4),y)

KMSCUBE_VERSION = 4660a7dca6512b6e658759d00cff7d4ad2a2059d
KMSCUBE_SITE = https://gitlab.freedesktop.org/mesa/kmscube/-/archive/$(KMSCUBE_VERSION)
KMSCUBE_LICENSE = MIT
KMSCUBE_DEPENDENCIES = host-pkgconf mesa3d libdrm

$(eval $(meson-package))

else

KMSCUBE_VERSION = 76bb57d539cb43d267e561024c34e031bf351e04
KMSCUBE_SITE = https://gitlab.freedesktop.org/mesa/kmscube/-/archive/$(KMSCUBE_VERSION)
KMSCUBE_LICENSE = MIT
KMSCUBE_DEPENDENCIES = host-pkgconf mesa3d libdrm
KMSCUBE_AUTORECONF = YES

ifeq ($(BR2_PACKAGE_LIBYXOPE)x,yx)
KMSCUBE_DEPENDENCIES += libyxope
override KMSCUBE_LIBGBM_LDFLAGS += $(shell $(PKG_CONFIG_HOST_BINARY) --libs gbm)
override KMSCUBE_LIBEGL_LDFLAGS += $(shell $(PKG_CONFIG_HOST_BINARY) --libs egl)
KMSCUBE_CONF_OPTS += GBM_LIBS="$(KMSCUBE_LIBGBM_LDFLAGS) -lRealgbm" EGL_LIBS="$(KMSCUBE_LIBEGL_LDFLAGS) -lRealEGL"
endif

ifeq ($(BR2_PACKAGE_KMSCUBE_LIBEPOXY)x,yx)
KMSCUBE_DEPENDENCIES += libepoxy
KMSCUBE_POST_PATCH_HOOKS += KMSCUBE_POST_PATCH_FIXUP
override KMSCUBE_LIBGBM_LDFLAGS += $(shell $(PKG_CONFIG_HOST_BINARY) --libs gbm)
override KMSCUBE_LIBEPOXY_LDFLAGS += $(shell $(PKG_CONFIG_HOST_BINARY) --libs epoxy)
KMSCUBE_CONF_OPTS += GBM_LIBS="$(KMSCUBE_LIBGBM_LDFLAGS) -lRealgbm" EGL_LIBS="$(KMSCUBE_LIBEPOXY_LDFLAGS)"
define KMSCUBE_POST_PATCH_FIXUP
[ -d $(KMSCUBE_PKGDIR)/$(KMSCUBE_VERSION) ] && \
$(APPLY_PATCHES) $(@D) $(KMSCUBE_PKGDIR)/$(KMSCUBE_VERSION) *.patch.hooked
endef
endif

$(eval $(autotools-package))

endif
