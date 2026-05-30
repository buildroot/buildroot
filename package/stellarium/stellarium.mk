################################################################################
#
# stellarium
#
################################################################################

STELLARIUM_VERSION = 25.4
STELLARIUM_SOURCE = stellarium-$(STELLARIUM_VERSION).tar.xz
STELLARIUM_SITE = https://github.com/Stellarium/stellarium/releases/download/v$(STELLARIUM_VERSION)
STELLARIUM_LICENSE = GPL-2.0+
STELLARIUM_LICENSE_FILES = COPYING

STELLARIUM_EXTRA_DOWNLOADS = \
	https://github.com/mity/md4c/archive/refs/tags/release-0.5.2.tar.gz \
	https://github.com/stevengj/nlopt/archive/refs/tags/v2.9.0.tar.gz

# Prevent stellarium from downloading stuff during its configure step
define STELLARIUM_COPY_EXTRA_DOWNLOADS
	mkdir -p $(@D)/_deps/md4c-subbuild/md4c-populate-prefix/src/
	cp $(STELLARIUM_DL_DIR)/release-0.5.2.tar.gz $(@D)/_deps/md4c-subbuild/md4c-populate-prefix/src/
	mkdir -p $(@D)/_deps/nlopt-subbuild/nlopt-populate-prefix/src/
	cp $(STELLARIUM_DL_DIR)/v2.9.0.tar.gz $(@D)/_deps/nlopt-subbuild/nlopt-populate-prefix/src/
endef
STELLARIUM_POST_EXTRACT_HOOKS += STELLARIUM_COPY_EXTRA_DOWNLOADS

STELLARIUM_DEPENDENCIES = \
	qt5base \
	qt5charts \
	qt5location \
	qt5multimedia \
	zlib
STELLARIUM_CONF_OPTS = \
	-DENABLE_MEDIA=ON \
	-DENABLE_NLS=OFF \
	-DENABLE_SHOWMYSKY=OFF \
	-DENABLE_QTWEBENGINE=OFF \
	-DENABLE_QT6=OFF \
	-DENABLE_XLSX=OFF \
	-DUSE_PLUGIN_TELESCOPECONTROL=OFF \
	-DUSE_SYSTEM_ZLIB=ON

ifeq ($(BR2_PACKAGE_QT5SCRIPT),y)
STELLARIUM_DEPENDENCIES += qt5script
STELLARIUM_CONF_OPTS += -DENABLE_SCRIPTING=ON
else
STELLARIUM_CONF_OPTS += -DENABLE_SCRIPTING=OFF
endif

ifeq ($(BR2_PACKAGE_GPSD)$(BR2_PACKAGE_QT5SERIALPORT),yy)
STELLARIUM_DEPENDENCIES += gpsd qt5serialport
STELLARIUM_CONF_OPTS += -DENABLE_GPS=ON
else
STELLARIUM_CONF_OPTS += -DENABLE_GPS=OFF
endif

$(eval $(cmake-package))
