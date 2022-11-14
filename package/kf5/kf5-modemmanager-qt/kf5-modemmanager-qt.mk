################################################################################
#
# kf5-modemmanager-qt
#
################################################################################

KF5_MODEMMANAGER_QT_VERSION = $(KF5_VERSION)
KF5_MODEMMANAGER_QT_SITE = $(KF5_SITE)
KF5_MODEMMANAGER_QT_SOURCE = modemmanager-qt-$(KF5_MODEMMANAGER_QT_VERSION).tar.xz
KF5_MODEMMANAGER_QT_LICENSE = \
	LGPL-2.1 or LGPL-3.0 or LicenseRef-KDE-Accepted-LGPL (library), \
	GPL-2.0 or GPL-3.0 or LicenseRef-KDE-Accepted-GPL (autotests, examples)

KF5_MODEMMANAGER_QT_LICENSE_FILES = \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/GPL-3.0-only.txt \
	LICENSES/LGPL-2.1-only.txt \
	LICENSES/LGPL-3.0-only.txt \
	LICENSES/LicenseRef-KDE-Accepted-GPL.txt \
	LICENSES/LicenseRef-KDE-Accepted-LGPL.txt

KF5_MODEMMANAGER_QT_DEPENDENCIES = kf5-extra-cmake-modules modem-manager qt5base
KF5_MODEMMANAGER_QT_INSTALL_STAGING = YES

# Uses __atomic_fetch_add_4
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
KF5_MODEMMANAGER_QT_CONF_OPTS += -DCMAKE_EXE_LINKER_FLAGS=-latomic
endif

$(eval $(cmake-package))
