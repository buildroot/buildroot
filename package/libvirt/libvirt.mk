################################################################################
#
# libvirt
#
################################################################################

LIBVIRT_VERSION = 7.4.0
LIBVIRT_SITE = https://libvirt.org/sources
LIBVIRT_SOURCE = libvirt-$(LIBVIRT_VERSION).tar.xz
LIBVIRT_LICENSE = LGPL-2.1+
LIBVIRT_LICENSE_FILES = COPYING
LIBVIRT_DEPENDENCIES = host-nfs-utils host-pkgconf host-python-docutils \
	gnutls libglib2 libpciaccess libtirpc libxml2 udev zlib

LIBVIRT_CONF_ENV += \
	CFLAGS="$(TARGET_CFLAGS) `$(PKG_CONFIG_HOST_BINARY) --cflags libtirpc`" \
	LIBS="`$(PKG_CONFIG_HOST_BINARY) --libs libtirpc`"

LIBVIRT_CONF_OPTS = \
	-Drpath=disabled \
	-Dapparmor=disabled \
	-Ddriver_bhyve=disabled \
	-Ddriver_esx=disabled \
	-Ddriver_hyperv=disabled \
	-Ddriver_interface=enabled \
	-Ddriver_libxl=disabled \
	-Ddriver_lxc=disabled \
	-Ddriver_network=disabled \
	-Ddriver_openvz=disabled \
	-Ddriver_qemu=disabled \
	-Ddriver_remote=enabled \
	-Ddriver_secrets=enabled \
	-Ddriver_vbox=disabled \
	-Ddriver_vmware=disabled \
	-Ddriver_vz=disabled \
	-Ddtrace=disabled \
	-Dfirewalld=disabled \
	-Dfirewalld_zone=disabled \
	-Dglusterfs=disabled \
	-Dhost_validate=enabled \
	-Dinit_script=$(if $(BR2_INIT_SYSTEMD),systemd,none) \
	-Dlibssh=disabled \
	-Dlibvirtd=disabled \
	-Dlogin_shell=disabled \
	-Dnetcf=disabled \
	-Dnss=disabled \
	-Dnumad=disabled \
	-Dopenwsman=disabled \
	-Dpciaccess=enabled \
	-Dpm_utils=disabled \
	-Dsanlock=disabled \
	-Dsasl=disabled \
	-Dsecdriver_apparmor=disabled \
	-Dssh2=disabled \
	-Dstorage_iscsi=disabled \
	-Dstorage_iscsi_direct=disabled \
	-Dstorage_mpath=disabled \
	-Dsysctl_config=enabled \
	-Dtest_coverage=false \
	-Dudev=enabled \
	-Dwireshark_dissector=disabled

ifeq ($(BR2_PACKAGE_ATTR),y)
LIBVIRT_CONF_OPTS += -Dattr=enabled
LIBVIRT_DEPENDENCIES += attr
else
LIBVIRT_CONF_OPTS += -Dattr=disabled
endif

ifeq ($(BR2_PACKAGE_AUDIT),y)
LIBVIRT_CONF_OPTS += -Daudit=enabled
LIBVIRT_DEPENDENCIES += audit
else
LIBVIRT_CONF_OPTS += -Daudit=disabled
endif

ifeq ($(BR2_PACKAGE_BASH_COMPLETION),y)
LIBVIRT_CONF_OPTS += -Dbash_completion=enabled
LIBVIRT_DEPENDENCIES += bash-completion
else
LIBVIRT_CONF_OPTS += -Dbash_completion=disabled
endif

ifeq ($(BR2_PACKAGE_UTIL_LINUX_LIBBLKID),y)
LIBVIRT_CONF_OPTS += -Dblkid=enabled
LIBVIRT_DEPENDENCIES += util-linux
else
LIBVIRT_CONF_OPTS += -Dblkid=disabled
endif

ifeq ($(BR2_PACKAGE_LIBCAP_NG),y)
LIBVIRT_CONF_OPTS += -Dcapng=enabled
LIBVIRT_DEPENDENCIES += libcap-ng
else
LIBVIRT_CONF_OPTS += -Dcapng=disabled
endif

ifeq ($(BR2_PACKAGE_LIBCURL),y)
LIBVIRT_CONF_OPTS += -Dcurl=enabled
LIBVIRT_DEPENDENCIES += libcurl
else
LIBVIRT_CONF_OPTS += -Dcurl=disabled
endif

ifeq ($(BR2_PACKAGE_LIBFUSE),y)
LIBVIRT_CONF_OPTS += -Dfuse=enabled
LIBVIRT_DEPENDENCIES += libfuse
else
LIBVIRT_CONF_OPTS += -Dfuse=disabled
endif

ifeq ($(BR2_PACKAGE_LIBISCSI),y)
LIBVIRT_CONF_OPTS += -Dlibiscsi=enabled
LIBVIRT_DEPENDENCIES += libiscsi
else
LIBVIRT_CONF_OPTS += -Dlibiscsi=disabled
endif

ifeq ($(BR2_PACKAGE_LIBPCAP),y)
LIBVIRT_CONF_OPTS += -Dlibpcap=enabled
LIBVIRT_DEPENDENCIES += libpcap
else
LIBVIRT_CONF_OPTS += -Dlibpcap=disabled
endif

ifeq ($(BR2_PACKAGE_NUMACTL),y)
LIBVIRT_CONF_OPTS += -Dnumactl=enabled
LIBVIRT_DEPENDENCIES += numactl
else
LIBVIRT_CONF_OPTS += -Dnumactl=disabled
endif

ifeq ($(BR2_PACKAGE_POLKIT),y)
LIBVIRT_CONF_OPTS += -Dpolkit=enabled
LIBVIRT_DEPENDENCIES += polkit
else
LIBVIRT_CONF_OPTS += -Dpolkit=disabled
endif

ifeq ($(BR2_PACKAGE_READLINE),y)
LIBVIRT_CONF_OPTS += -Dreadline=enabled
LIBVIRT_DEPENDENCIES += readline
else
LIBVIRT_CONF_OPTS += -Dreadline=disabled
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
LIBVIRT_CONF_OPTS += -Dselinux=enabled -Dsecdriver_selinux=enabled \
	-Dselinux_mount=/sys/fs/selinux
LIBVIRT_DEPENDENCIES += libselinux
else
LIBVIRT_CONF_OPTS += -Dselinux=disabled -Dsecdriver_selinux=disabled
endif

ifeq ($(BR2_PACKAGE_LVM2),y)
LIBVIRT_CONF_OPTS += -Dstorage_lvm=enabled
LIBVIRT_DEPENDENCIES += lvm2
else
LIBVIRT_CONF_OPTS += -Dstorage_lvm=disabled
endif

ifeq ($(BR2_PACKAGE_YAJL),y)
LIBVIRT_CONF_OPTS += -Dyajl=enabled
LIBVIRT_DEPENDENCIES += yajl
else
LIBVIRT_CONF_OPTS += -Dyajl=disabled
endif

define LIBVIRT_INSTALL_UDEV_RULES
	$(INSTALL) -D -m 644 package/libvirt/90-kvm.rules \
		$(TARGET_DIR)/etc/udev/rules.d/90-kvm.rules
endef
LIBVIRT_POST_INSTALL_TARGET_HOOKS += LIBVIRT_INSTALL_UDEV_RULES

# Adjust directory ownerships and permissions. Notice /var/log is a symlink to
# /tmp in the default sysvinit skeleton, so some directories may disappear at
# run-time. Set the permissions anyway, since they are valid for the default
# systemd skeleton.
define LIBVIRT_PERMISSIONS
	/etc/libvirt                             d  700  root  root  -  -  -  -  -
	/etc/libvirt/nwfilter                    d  700  root  root  -  -  -  -  -
	/var/lib/libvirt                         d  755  root  root  -  -  -  -  -
	/var/lib/libvirt/boot                    d  711  root  root  -  -  -  -  -
	/var/lib/libvirt/dnsmasq                 d  755  root  root  -  -  -  -  -
	/var/lib/libvirt/filesystems             d  711  root  root  -  -  -  -  -
	/var/lib/libvirt/images                  d  711  root  root  -  -  -  -  -
	/var/lib/libvirt/network                 d  700  root  root  -  -  -  -  -
	/var/lib/libvirt/secrets                 d  700  root  root  -  -  -  -  -
	/var/lib/libvirt/storage                 d  755  root  root  -  -  -  -  -
	/var/lib/libvirt/storage/autostart       d  755  root  root  -  -  -  -  -
	/var/cache/libvirt                       d  711  root  root  -  -  -  -  -
	/var/log/libvirt                         d  700  root  root  -  -  -  -  -
	/var/log/swtpm                           d  755  root  root  -  -  -  -  -
	/var/log/swtpm/libvirt                   d  755  root  root  -  -  -  -  -
endef

# libvirt may need to create persistent files (e.g. VM definitions) in these
# directories. Move them to /var/lib because /etc may be on a read-only or
# volatile (initramfs) filesystem. We could tweak the code to change these
# paths but the patch would be large and would break compatibility with
# ordinary installations and with the documentation.
define LIBVIRT_CREATE_SYMLINKS
	$(INSTALL) -m 700 -d $(TARGET_DIR)/etc/libvirt
	$(INSTALL) -m 755 -d $(TARGET_DIR)/var/lib/libvirt
	$(INSTALL) -m 700 -d $(TARGET_DIR)/var/lib/libvirt/secrets
	$(INSTALL) -m 755 -d $(TARGET_DIR)/var/lib/libvirt/storage
	ln -s -f ../../var/lib/libvirt/secrets $(TARGET_DIR)/etc/libvirt/
	ln -s -f ../../var/lib/libvirt/storage $(TARGET_DIR)/etc/libvirt/
endef

LIBVIRT_PRE_INSTALL_TARGET_HOOKS += LIBVIRT_CREATE_SYMLINKS

$(eval $(meson-package))
