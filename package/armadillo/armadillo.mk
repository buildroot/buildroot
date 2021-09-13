################################################################################
#
# armadillo
#
################################################################################

ARMADILLO_VERSION = 9.900.2
ARMADILLO_SOURCE = armadillo-$(ARMADILLO_VERSION).tar.xz
ARMADILLO_SITE = https://downloads.sourceforge.net/project/arma
ARMADILLO_INSTALL_STAGING = YES
ARMADILLO_LICENSE = Apache-2.0
ARMADILLO_LICENSE_FILES = LICENSE.txt

ARMADILLO_CONF_OPTS = -DDETECT_HDF5=false

# blas support may be provided by lapack (libblas.a) or openblas (libopenblas.a)
ARMADILLO_CONF_OPTS += -DBLAS_FOUND=ON
ifeq ($(BR2_PACKAGE_ARMADILLO_OPENBLAS),y)
ARMADILLO_CONF_OPTS += -DBLAS_LIBRARIES=-lopenblas
ARMADILLO_DEPENDENCIES = openblas
else
# Since BR2_PACKAGE_LAPACK is selected in this case, the dependency on it is
# added below.
ARMADILLO_CONF_OPTS += -DBLAS_LIBRARIES=-lblas
endif

# lapack support is optional and can only be provided by lapack, not openblas
ifeq ($(BR2_PACKAGE_LAPACK),y)
ARMADILLO_CONF_OPTS += -DLAPACK_FOUND=ON
ARMADILLO_DEPENDENCIES += lapack
endif

$(eval $(cmake-package))
