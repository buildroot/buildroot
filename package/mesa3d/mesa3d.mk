################################################################################
#
# mesa3d
#
################################################################################

# When updating the version, please also update mesa3d-headers
MESA3D_VERSION = 25.0.6
MESA3D_SOURCE = mesa-$(MESA3D_VERSION).tar.xz
MESA3D_SITE = https://archive.mesa3d.org
MESA3D_LICENSE = MIT, SGI, Khronos
MESA3D_LICENSE_FILES = \
	docs/license.rst \
	licenses/MIT \
	licenses/SGI-B-2.0
MESA3D_CPE_ID_VENDOR = mesa3d
MESA3D_CPE_ID_PRODUCT = mesa

MESA3D_INSTALL_STAGING = YES

MESA3D_PROVIDES =

MESA3D_DEPENDENCIES = \
	host-bison \
	host-flex \
	host-python-mako \
	host-python-pyyaml \
	expat \
	libdrm \
	zlib

MESA3D_CONF_OPTS = \
	-Dgallium-opencl=disabled \
	-Dgallium-rusticl=false \
	-Dmicrosoft-clc=disabled \
	-Dpower8=disabled

ifeq ($(BR2_PACKAGE_MESA3D_DRIVER)$(BR2_PACKAGE_XORG7),yy)
MESA3D_DEPENDENCIES += xlib_libxshmfence
endif

ifeq ($(BR2_PACKAGE_MESA3D_LLVM),y)
MESA3D_DEPENDENCIES += host-llvm llvm
MESA3D_MESON_EXTRA_BINARIES += llvm-config='$(STAGING_DIR)/usr/bin/llvm-config'
MESA3D_CONF_OPTS += -Dllvm=enabled
ifeq ($(BR2_PACKAGE_LLVM_RTTI),y)
MESA3D_CONF_OPTS += -Dcpp_rtti=true
else
MESA3D_CONF_OPTS += -Dcpp_rtti=false
endif
else
# Avoid automatic search of llvm-config
MESA3D_CONF_OPTS += -Dllvm=disabled
endif

ifeq ($(BR2_PACKAGE_MESA3D_OPENCL),y)
MESA3D_PROVIDES += libopencl
MESA3D_DEPENDENCIES += clang libclc
endif

ifeq ($(BR2_PACKAGE_MESA3D_NEEDS_ELFUTILS),y)
MESA3D_DEPENDENCIES += elfutils
endif

ifeq ($(BR2_PACKAGE_MESA3D_OPENGL_GLX),y)
# Disable-mangling not yet supported by meson build system.
# glx:
#  dri          : dri based GLX requires at least one DRI driver || dri based GLX requires shared-glapi
#  xlib         : xlib conflicts with any dri driver
# Always enable glx-direct; without it, many GLX applications don't work.
MESA3D_CONF_OPTS += \
	-Dglx=dri \
	-Dglx-direct=true
ifeq ($(BR2_PACKAGE_MESA3D_NEEDS_XA),y)
MESA3D_CONF_OPTS += -Dgallium-xa=enabled
else
MESA3D_CONF_OPTS += -Dgallium-xa=disabled
endif
else
MESA3D_CONF_OPTS += \
	-Dglx=disabled \
	-Dgallium-xa=disabled
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
MESA3D_CONF_OPTS += -Dgallium-vc4-neon=auto
else
MESA3D_CONF_OPTS += -Dgallium-vc4-neon=disabled
endif

# Drivers

#Gallium Drivers
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_CROCUS)   += crocus
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_ETNAVIV)  += etnaviv
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_FREEDRENO) += freedreno
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_I915)     += i915
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_IRIS)     += iris
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_LIMA)     += lima
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_LLVMPIPE) += llvmpipe
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_NOUVEAU)  += nouveau
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_PANFROST) += panfrost
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_R300)     += r300
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_R600)     += r600
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_RADEONSI) += radeonsi
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_SVGA)     += svga
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_SOFTPIPE) += softpipe
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_TEGRA)    += tegra
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_V3D)      += v3d
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_VC4)      += vc4
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_VIRGL)    += virgl
MESA3D_GALLIUM_DRIVERS-$(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_ZINK)     += zink
# Vulkan Drivers
MESA3D_VULKAN_DRIVERS-$(BR2_PACKAGE_MESA3D_VULKAN_DRIVER_BROADCOM) += broadcom
MESA3D_VULKAN_DRIVERS-$(BR2_PACKAGE_MESA3D_VULKAN_DRIVER_INTEL)   += intel
MESA3D_VULKAN_DRIVERS-$(BR2_PACKAGE_MESA3D_VULKAN_DRIVER_SWRAST) += swrast
MESA3D_VULKAN_DRIVERS-$(BR2_PACKAGE_MESA3D_VULKAN_DRIVER_VIRTIO) += virtio

ifeq ($(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER),)
MESA3D_CONF_OPTS += \
	-Dgallium-drivers= \
	-Dgallium-extra-hud=false
else
MESA3D_CONF_OPTS += \
	-Dshared-glapi=enabled \
	-Dgallium-drivers=$(subst $(space),$(comma),$(MESA3D_GALLIUM_DRIVERS-y)) \
	-Dgallium-extra-hud=true
endif

ifeq ($(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_ETNAVIV),y)
MESA3D_DEPENDENCIES += host-python-pycparser
endif

ifeq ($(BR2_PACKAGE_MESA3D_VULKAN_DRIVER_INTEL),y)
MESA3D_DEPENDENCIES += host-python-ply
MESA3D_CONF_OPTS += -Dmesa-clc=system -Dprecomp-compiler=system
MESA3D_DEPENDENCIES += host-mesa3d spirv-llvm-translator spirv-tools
endif

ifeq ($(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_IRIS),y)
MESA3D_CONF_OPTS += -Dmesa-clc=system -Dprecomp-compiler=system
MESA3D_DEPENDENCIES += host-mesa3d spirv-llvm-translator spirv-tools
endif

ifeq ($(BR2_PACKAGE_MESA3D_VULKAN_DRIVER),)
MESA3D_CONF_OPTS += \
	-Dvulkan-drivers=
else
MESA3D_DEPENDENCIES += host-python-glslang
MESA3D_CONF_OPTS += \
	-Dvulkan-drivers=$(subst $(space),$(comma),$(MESA3D_VULKAN_DRIVERS-y))
endif

# APIs

ifeq ($(BR2_PACKAGE_MESA3D_OSMESA_GALLIUM),y)
MESA3D_CONF_OPTS += -Dosmesa=true
else
MESA3D_CONF_OPTS += -Dosmesa=false
endif

# Always enable OpenGL:
#   - Building OpenGL ES without OpenGL is not supported, so always keep opengl enabled.
MESA3D_CONF_OPTS += -Dopengl=true

# libva and mesa3d have a circular dependency
# we do not need libva support in mesa3d, therefore disable this option
MESA3D_CONF_OPTS += -Dgallium-va=disabled

# libGL is only provided for a full xorg stack, without libglvnd
ifeq ($(BR2_PACKAGE_MESA3D_OPENGL_GLX),y)
MESA3D_PROVIDES += $(if $(BR2_PACKAGE_LIBGLVND),,libgl)
else
define MESA3D_REMOVE_OPENGL_HEADERS
	rm -rf $(STAGING_DIR)/usr/include/GL/
endef

MESA3D_POST_INSTALL_STAGING_HOOKS += MESA3D_REMOVE_OPENGL_HEADERS
endif

ifeq ($(BR2_PACKAGE_MESA3D_NEEDS_X11),y)
MESA3D_DEPENDENCIES += \
	xlib_libX11 \
	xlib_libXext \
	xlib_libXdamage \
	xlib_libXfixes \
	xlib_libXrandr \
	xlib_libXxf86vm \
	xorgproto \
	libxcb
MESA3D_PLATFORMS += x11
endif
ifeq ($(BR2_PACKAGE_WAYLAND),y)
MESA3D_DEPENDENCIES += wayland wayland-protocols
MESA3D_PLATFORMS += wayland
endif

MESA3D_CONF_OPTS += \
	-Dplatforms=$(subst $(space),$(comma),$(MESA3D_PLATFORMS))

ifeq ($(BR2_PACKAGE_MESA3D_GBM),y)
MESA3D_CONF_OPTS += \
	-Dgbm=enabled
else
MESA3D_CONF_OPTS += \
	-Dgbm=disabled
endif

ifeq ($(BR2_PACKAGE_MESA3D_OPENGL_EGL),y)
MESA3D_PROVIDES += $(if $(BR2_PACKAGE_LIBGLVND),,libegl)
MESA3D_CONF_OPTS += \
	-Degl=enabled
else
MESA3D_CONF_OPTS += \
	-Degl=disabled
endif

ifeq ($(BR2_PACKAGE_MESA3D_OPENGL_ES),y)
MESA3D_PROVIDES += $(if $(BR2_PACKAGE_LIBGLVND),,libgles)
MESA3D_CONF_OPTS += -Dgles1=enabled -Dgles2=enabled
else
MESA3D_CONF_OPTS += -Dgles1=disabled -Dgles2=disabled
endif

ifeq ($(BR2_PACKAGE_VALGRIND),y)
MESA3D_CONF_OPTS += -Dvalgrind=enabled
MESA3D_DEPENDENCIES += valgrind
else
MESA3D_CONF_OPTS += -Dvalgrind=disabled
endif

ifeq ($(BR2_PACKAGE_LIBUNWIND),y)
MESA3D_CONF_OPTS += -Dlibunwind=enabled
MESA3D_DEPENDENCIES += libunwind
else
MESA3D_CONF_OPTS += -Dlibunwind=disabled
endif

ifeq ($(BR2_PACKAGE_MESA3D_VDPAU),y)
MESA3D_DEPENDENCIES += libvdpau
MESA3D_CONF_OPTS += -Dgallium-vdpau=enabled
else
MESA3D_CONF_OPTS += -Dgallium-vdpau=disabled
endif

ifeq ($(BR2_PACKAGE_LM_SENSORS),y)
MESA3D_CONF_OPTS += -Dlmsensors=enabled
MESA3D_DEPENDENCIES += lm-sensors
else
MESA3D_CONF_OPTS += -Dlmsensors=disabled
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
MESA3D_CONF_OPTS += -Dzstd=enabled
MESA3D_DEPENDENCIES += zstd
else
MESA3D_CONF_OPTS += -Dzstd=disabled
endif

MESA3D_CFLAGS = $(TARGET_CFLAGS)

# m68k needs 32-bit offsets in switch tables to build
ifeq ($(BR2_m68k),y)
MESA3D_CFLAGS += -mlong-jump-table-offsets
endif

ifeq ($(BR2_PACKAGE_LIBGLVND),y)
ifneq ($(BR2_PACKAGE_MESA3D_OPENGL_GLX)$(BR2_PACKAGE_MESA3D_OPENGL_EGL),)
MESA3D_DEPENDENCIES += libglvnd
MESA3D_CONF_OPTS += -Dglvnd=enabled
else
MESA3D_CONF_OPTS += -Dglvnd=disabled
endif
else
MESA3D_CONF_OPTS += -Dglvnd=disabled
endif

# host-mesa3d is needed by mesa3d only when the Iris Gallium driver is
# enabled
HOST_MESA3D_CONF_OPTS = \
	-Dglvnd=disabled \
	-Dgallium-drivers=iris \
	-Dgallium-vdpau=disabled \
	-Dinstall-mesa-clc=true \
	-Dmesa-clc=enabled \
	-Dplatforms= \
	-Dprecomp-compiler=enabled \
	-Dglx=disabled \
	-Dvulkan-drivers=""

HOST_MESA3D_DEPENDENCIES = \
	host-libclc \
	host-libdrm \
	host-python-mako \
	host-python-pyyaml \
	host-spirv-tools

define HOST_MESA3D_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/buildroot-build/src/compiler/clc/mesa_clc $(HOST_DIR)/bin/mesa_clc
	$(INSTALL) -D -m 0755 $(@D)/buildroot-build/src/compiler/spirv/vtn_bindgen $(HOST_DIR)/bin/vtn_bindgen
endef

$(eval $(meson-package))
$(eval $(host-meson-package))
