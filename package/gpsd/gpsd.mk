################################################################################
#
# gpsd
#
################################################################################

GPSD_VERSION = 3.25
GPSD_SITE = http://download-mirror.savannah.gnu.org/releases/gpsd
GPSD_LICENSE = BSD-2-Clause
GPSD_LICENSE_FILES = COPYING
GPSD_CPE_ID_VALID = YES
GPSD_SELINUX_MODULES = gpsd
GPSD_INSTALL_STAGING = YES

GPSD_DEPENDENCIES = host-scons host-pkgconf

GPSD_LDFLAGS = $(TARGET_LDFLAGS)
GPSD_CFLAGS = $(TARGET_CFLAGS)
GPSD_CXXFLAGS = $(TARGET_CXXFLAGS)

GPSD_SCONS_ENV = $(TARGET_CONFIGURE_OPTS)

GPSD_SCONS_OPTS = \
	arch=$(ARCH) \
	manbuild=no \
	prefix=/usr \
	sysroot=$(STAGING_DIR) \
	strip=no \
	qt=no

ifeq ($(BR2_PACKAGE_NCURSES),y)
GPSD_DEPENDENCIES += ncurses
else
GPSD_SCONS_OPTS += ncurses=no
endif

# Build libgpsmm if we've got C++
ifeq ($(BR2_INSTALL_LIBSTDCPP),y)
GPSD_LDFLAGS += -lstdc++
GPSD_CFLAGS += -std=gnu++98
GPSD_CXXFLAGS += -std=gnu++98
GPSD_SCONS_OPTS += libgpsmm=yes
else
GPSD_SCONS_OPTS += libgpsmm=no
endif

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_68485),y)
GPSD_CFLAGS += -O0
GPSD_CXXFLAGS += -O0
endif

# If libusb is available build it before so the package can use it
ifeq ($(BR2_PACKAGE_LIBUSB),y)
GPSD_DEPENDENCIES += libusb
else
GPSD_SCONS_OPTS += usb=no
endif

# If bluetooth is available build it before so the package can use it
ifeq ($(BR2_PACKAGE_BLUEZ5_UTILS),y)
GPSD_DEPENDENCIES += bluez5_utils
else
GPSD_SCONS_OPTS += bluez=no
endif

# If pps-tools is available, build it before so the package can use it
# (HAVE_SYS_TIMEPPS_H).
ifeq ($(BR2_PACKAGE_PPS_TOOLS),y)
GPSD_DEPENDENCIES += pps-tools
endif

ifeq ($(BR2_PACKAGE_DBUS_GLIB),y)
GPSD_SCONS_OPTS += dbus_export=yes
GPSD_DEPENDENCIES += dbus-glib
endif

# Protocol support
ifneq ($(BR2_PACKAGE_GPSD_ASHTECH),y)
GPSD_SCONS_OPTS += ashtech=no
endif
ifneq ($(BR2_PACKAGE_GPSD_AIVDM),y)
GPSD_SCONS_OPTS += aivdm=no
endif
ifneq ($(BR2_PACKAGE_GPSD_EARTHMATE),y)
GPSD_SCONS_OPTS += earthmate=no
endif
ifneq ($(BR2_PACKAGE_GPSD_EVERMORE),y)
GPSD_SCONS_OPTS += evermore=no
endif
ifneq ($(BR2_PACKAGE_GPSD_FURY),y)
GPSD_SCONS_OPTS += fury=no
endif
ifneq ($(BR2_PACKAGE_GPSD_FV18),y)
GPSD_SCONS_OPTS += fv18=no
endif
ifneq ($(BR2_PACKAGE_GPSD_GARMIN),y)
GPSD_SCONS_OPTS += garmin=no
endif
ifneq ($(BR2_PACKAGE_GPSD_GARMIN_SIMPLE_TXT),y)
GPSD_SCONS_OPTS += garmintxt=no
endif
ifneq ($(BR2_PACKAGE_GPSD_GEOSTAR),y)
GPSD_SCONS_OPTS += geostar=no
endif
ifneq ($(BR2_PACKAGE_GPSD_GPSCLOCK),y)
GPSD_SCONS_OPTS += gpsclock=no
endif
ifneq ($(BR2_PACKAGE_GPSD_GREIS),y)
GPSD_SCONS_OPTS += greis=no
endif
ifneq ($(BR2_PACKAGE_GPSD_ISYNC),y)
GPSD_SCONS_OPTS += isync=no
endif
ifneq ($(BR2_PACKAGE_GPSD_ITRAX),y)
GPSD_SCONS_OPTS += itrax=no
endif
ifneq ($(BR2_PACKAGE_GPSD_NAVCOM),y)
GPSD_SCONS_OPTS += navcom=no
endif
ifneq ($(BR2_PACKAGE_GPSD_NMEA2000),y)
GPSD_SCONS_OPTS += nmea2000=no
endif
ifneq ($(BR2_PACKAGE_GPSD_OCEANSERVER),y)
GPSD_SCONS_OPTS += oceanserver=no
endif
ifneq ($(BR2_PACKAGE_GPSD_ONCORE),y)
GPSD_SCONS_OPTS += oncore=no
endif
ifneq ($(BR2_PACKAGE_GPSD_RTCM104V2),y)
GPSD_SCONS_OPTS += rtcm104v2=no
endif
ifneq ($(BR2_PACKAGE_GPSD_RTCM104V3),y)
GPSD_SCONS_OPTS += rtcm104v3=no
endif
ifneq ($(BR2_PACKAGE_GPSD_SIRF),y)
GPSD_SCONS_OPTS += sirf=no
endif
ifneq ($(BR2_PACKAGE_GPSD_SKYTRAQ),y)
GPSD_SCONS_OPTS += skytraq=no
endif
ifneq ($(BR2_PACKAGE_GPSD_SUPERSTAR2),y)
GPSD_SCONS_OPTS += superstar2=no
endif
ifneq ($(BR2_PACKAGE_GPSD_TRIMBLE_TSIP),y)
GPSD_SCONS_OPTS += tsip=no
endif
ifneq ($(BR2_PACKAGE_GPSD_TRIPMATE),y)
GPSD_SCONS_OPTS += tripmate=no
endif
ifneq ($(BR2_PACKAGE_GPSD_TRUE_NORTH),y)
GPSD_SCONS_OPTS += tnt=no
endif
ifneq ($(BR2_PACKAGE_GPSD_UBX),y)
GPSD_SCONS_OPTS += ublox=no
endif

# Features
ifeq ($(BR2_PACKAGE_GPSD_SQUELCH),y)
GPSD_SCONS_OPTS += squelch=yes
endif
ifeq ($(BR2_PACKAGE_GPSD_PROFILING),y)
GPSD_SCONS_OPTS += profiling=yes
endif
ifneq ($(BR2_PACKAGE_GPSD_CLIENT_DEBUG),y)
GPSD_SCONS_OPTS += clientdebug=no
endif
ifeq ($(BR2_PACKAGE_GPSD_USER),y)
GPSD_SCONS_OPTS += gpsd_user=$(BR2_PACKAGE_GPSD_USER_VALUE)
endif
ifeq ($(BR2_PACKAGE_GPSD_GROUP),y)
GPSD_SCONS_OPTS += gpsd_group=$(BR2_PACKAGE_GPSD_GROUP_VALUE)
endif
ifeq ($(BR2_PACKAGE_GPSD_MAX_CLIENT),y)
GPSD_SCONS_OPTS += max_clients=$(BR2_PACKAGE_GPSD_MAX_CLIENT_VALUE)
endif
ifeq ($(BR2_PACKAGE_GPSD_MAX_DEV),y)
GPSD_SCONS_OPTS += max_devices=$(BR2_PACKAGE_GPSD_MAX_DEV_VALUE)
endif

ifeq ($(BR2_PACKAGE_GPSD_DAEMON),y)
GPSD_SCONS_OPTS += \
	gpsd=yes \
	systemd=$(if $(BR2_INIT_SYSTEMD),yes,no)

GPSD_INSTALL_RULE = $(if $(BR2_PACKAGE_HAS_UDEV),udev-install,install)

# When using chrony, wait for after Buildroot's chrony.service
ifeq ($(BR2_PACKAGE_CHRONY),y)
define GPSD_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(GPSD_PKGDIR)/br-chrony.conf \
		$(TARGET_DIR)/usr/lib/systemd/system/gpsd.service.d/br-chrony.conf
endef
endif

define GPSD_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/gpsd/S50gpsd $(TARGET_DIR)/etc/init.d/S50gpsd
	$(SED) 's,^DEVICES=.*,DEVICES=$(BR2_PACKAGE_GPSD_DEVICES),' $(TARGET_DIR)/etc/init.d/S50gpsd
endef

# After the udev rule is installed, make it writable so that this
# package can be re-built/re-installed.
ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
define GPSD_INSTALL_UDEV_RULES
	chmod u+w $(TARGET_DIR)/lib/udev/rules.d/25-gpsd.rules
endef
GPSD_POST_INSTALL_TARGET_HOOKS += GPSD_INSTALL_UDEV_RULES
endif

else # GPSD_DAEMON
GPSD_SCONS_OPTS += gpsd=no systemd=no
GPSD_INSTALL_RULE = install
endif

ifeq ($(BR2_PACKAGE_GPSD_CLIENTS),y)
GPSD_SCONS_OPTS += gpsdclients=yes
else
GPSD_SCONS_OPTS += gpsdclients=no
endif

ifeq ($(BR2_PACKAGE_GPSD_PYTHON),y)
GPSD_SCONS_OPTS += \
	python=yes \
	python_libdir="/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages"
else
GPSD_SCONS_OPTS += python=no
endif

GPSD_SCONS_ENV += \
	LDFLAGS="$(GPSD_LDFLAGS)" \
	CFLAGS="$(GPSD_CFLAGS)" \
	CCFLAGS="$(GPSD_CFLAGS)" \
	CXXFLAGS="$(GPSD_CXXFLAGS)"

define GPSD_BUILD_CMDS
	(cd $(@D); \
		$(GPSD_SCONS_ENV) \
		$(SCONS) \
		$(GPSD_SCONS_OPTS))
endef

define GPSD_INSTALL_TARGET_CMDS
	(cd $(@D); \
		$(GPSD_SCONS_ENV) \
		DESTDIR=$(TARGET_DIR) \
		$(SCONS) \
		$(GPSD_SCONS_OPTS) \
		$(GPSD_INSTALL_RULE))
endef

define GPSD_INSTALL_STAGING_CMDS
	(cd $(@D); \
		$(GPSD_SCONS_ENV) \
		DESTDIR=$(STAGING_DIR) \
		$(SCONS) \
		$(GPSD_SCONS_OPTS) \
		install)
endef

$(eval $(generic-package))
