################################################################################
#
# kf5-networkmanager-qt
#
################################################################################

KF5_NETWORKMANAGER_QT_VERSION = $(KF5_VERSION)
KF5_NETWORKMANAGER_QT_SITE = $(KF5_SITE)
KF5_NETWORKMANAGER_QT_SOURCE = networkmanager-qt-$(KF5_NETWORKMANAGER_QT_VERSION).tar.xz
KF5_NETWORKMANAGER_QT_LICENSE = \
	LGPL-2.1 or LGPL-3.0 or LicenseRef-KDE-Accepted-LGPL (library), \
	GPL-2.0 or GPL-3.0 or LicenseRef-KDE-Accepted-GPL (autotests, examples)
KF5_NETWORKMANAGER_QT_LICENSE_FILES = \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/GPL-3.0-only.txt \
	LICENSES/LGPL-2.1-only.txt \
	LICENSES/LGPL-3.0-only.txt \
	LICENSES/LicenseRef-KDE-Accepted-GPL.txt \
	LICENSES/LicenseRef-KDE-Accepted-LGPL.txt

KF5_NETWORKMANAGER_QT_DEPENDENCIES = kf5-extra-cmake-modules network-manager qt5base
KF5_NETWORKMANAGER_QT_INSTALL_STAGING = YES

$(eval $(cmake-package))
