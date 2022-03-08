################################################################################
#
# kf5-kcoreaddons
#
################################################################################

KF5_KCOREADDONS_VERSION = $(KF5_VERSION)
KF5_KCOREADDONS_SITE = $(KF5_SITE)
KF5_KCOREADDONS_SOURCE = kcoreaddons-$(KF5_KCOREADDONS_VERSION).tar.xz
KF5_KCOREADDONS_LICENSE = \
	LGPL-2.0+, LGPL-2.1 or LGPL-3.0 or LicenseRef-KDE-Accepted-LGPL (library), \
	MPL.1.1 or GPL-2.0+ or LGPL-2.1+ (posix_fallocate_mac.h), \
	LGPL-2.1 with Qt-LGPL-exception-1.1 or LicenseRef-Qt-Commercial (kprocesslist), \
	GPL-2.0 or GPL-3.0 or LicenseRef-KDE-Accepted-GPL (autotests)
KF5_KCOREADDONS_LICENSE_FILES = \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/GPL-2.0-or-later.txt \
	LICENSES/GPL-3.0-only.txt \
	LICENSES/LGPL-2.0-only.txt \
	LICENSES/LGPL-2.0-or-later.txt \
	LICENSES/LGPL-2.1-only.txt \
	LICENSES/LGPL-3.0-only.txt \
	LICENSES/LicenseRef-KDE-Accepted-GPL.txt \
	LICENSES/LicenseRef-KDE-Accepted-LGPL.txt \
	LICENSES/LicenseRef-Qt-Commercial.txt \
	LICENSES/MPL-1.1.txt \
	LICENSES/Qt-LGPL-exception-1.1.txt

KF5_KCOREADDONS_DEPENDENCIES = \
	kf5-extra-cmake-modules \
	qt5tools \
	$(if $(BR2_PACKAGE_PYTHON3),python3)
KF5_KCOREADDONS_INSTALL_STAGING = YES

KF5_KCOREADDONS_CXXFLAGS = $(TARGET_CXXFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
KF5_KCOREADDONS_CXXFLAGS += -latomic
endif

KF5_KCOREADDONS_CONF_OPTS = -DCMAKE_CXX_FLAGS="$(KF5_KCOREADDONS_CXXFLAGS)"

ifeq ($(BR2_microblaze),y)
# Microblaze ld emits warnings, make warnings not to be treated as errors
KF5_KCOREADDONS_CONF_OPTS += -DCMAKE_SHARED_LINKER_FLAGS="-Wl,--no-fatal-warnings"
endif

$(eval $(cmake-package))
