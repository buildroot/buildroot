################################################################################
#
# eigen
#
################################################################################

EIGEN_VERSION = 5.0.1
EIGEN_SOURCE = eigen-$(EIGEN_VERSION).tar.bz2
EIGEN_SITE = $(call gitlab,libeigen,eigen,$(EIGEN_VERSION))
EIGEN_LICENSE = MPL-2.0, BSD-3-Clause, Apache-2.0, Minpack
EIGEN_LICENSE_FILES = COPYING.MPL2 COPYING.BSD COPYING.APACHE COPYING.MINPACK COPYING.README
EIGEN_INSTALL_STAGING = YES
EIGEN_INSTALL_TARGET = NO
EIGEN_SUPPORTS_IN_SOURCE_BUILD = NO

# Default Eigen CMake installs .pc file in /usr/share/pkgconfig
# change it to /usr/lib/pkgconfig, to be consistent with other packages.
EIGEN_CONF_OPTS = -DPKGCONFIG_INSTALL_DIR=/usr/lib/pkgconfig

ifeq ($(BR2_TOOLCHAIN_HAS_FORTRAN),y)
EIGEN_CONF_OPTS += \
	-DCMAKE_Fortran_COMPILER=$(TARGET_FC) \
	-DEIGEN_BUILD_BLAS=ON \
	-DEIGEN_BUILD_LAPACK=ON
else
EIGEN_CONF_OPTS += \
	-DEIGEN_BUILD_BLAS=OFF \
	-DEIGEN_BUILD_LAPACK=OFF
endif

$(eval $(cmake-package))
