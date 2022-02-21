################################################################################
#
# libqmi
#
################################################################################

LIBQMI_VERSION = 1.30.4
LIBQMI_SITE = https://gitlab.freedesktop.org/mobile-broadband/libqmi/-/archive/$(LIBQMI_VERSION)
LIBQMI_LICENSE = LGPL-2.0+ (library), GPL-2.0+ (programs)
LIBQMI_LICENSE_FILES = COPYING COPYING.LIB
LIBQMI_CPE_ID_VENDOR = libqmi_project
LIBQMI_INSTALL_STAGING = YES

LIBQMI_DEPENDENCIES = libglib2
LIBQMI_CONF_OPTS = -Dman=false

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
LIBQMI_DEPENDENCIES += gobject-introspection
LIBQMI_CONF_OPTS += -Dintrospection=true
else
LIBQMI_CONF_OPTS += -Dintrospection=false
endif

# if libgudev available, request udev support for a better
# qmi-firmware-update experience
ifeq ($(BR2_PACKAGE_LIBGUDEV),y)
LIBQMI_DEPENDENCIES += libgudev
LIBQMI_CONF_OPTS += -Dudev=true
else
LIBQMI_CONF_OPTS += -Dudev=false
endif

# if libmbim available, request QMI-over-MBIM support
ifeq ($(BR2_PACKAGE_LIBMBIM),y)
LIBQMI_DEPENDENCIES += libmbim
LIBQMI_CONF_OPTS += -Dmbim_qmux=true
else
LIBQMI_CONF_OPTS += -Dmbim_qmux=false
endif

# if libqrtr-glib available, enable support for QMI over QRTR
ifeq ($(BR2_PACKAGE_LIBQRTR_GLIB),y)
LIBQMI_DEPENDENCIES += libqrtr-glib
LIBQMI_CONF_OPTS += -Dqrtr=true
else
LIBQMI_CONF_OPTS += -Dqrtr=false
endif

# if ModemManager available, enable MM runtime check in
# qmi-firmware-update (note that we don't need to build-depend on
# anything else)
ifeq ($(BR2_PACKAGE_MODEM_MANAGER),y)
LIBQMI_CONF_OPTS += -Dmm_runtime_check=true
else
LIBQMI_CONF_OPTS += -Dmm_runtime_check=false
endif

ifeq ($(BR2_PACKAGE_BASH_COMPLETION),y)
LIBQMI_DEPENDENCIES += bash-completion
LIBQMI_CONF_OPTS += -Dbash_completion=true
else
LIBQMI_CONF_OPTS += -Dbash_completion=false
endif

$(eval $(meson-package))
