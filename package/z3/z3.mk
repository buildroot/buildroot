################################################################################
#
# z3
#
################################################################################

Z3_VERSION = 4.11.2
Z3_SITE = $(call github,Z3Prover,z3,z3-$(Z3_VERSION))
Z3_LICENSE = MIT
Z3_LICENSE_FILES = LICENSE.txt
Z3_INSTALL_STAGING = YES
Z3_SUPPORTS_IN_SOURCE_BUILD = NO

ifeq ($(BR2_PACKAGE_Z3_PYTHON),y)
Z3_CONF_OPTS += \
	-DCMAKE_INSTALL_PYTHON_PKG_DIR=/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages \
	-DZ3_BUILD_PYTHON_BINDINGS=ON
else
Z3_CONF_OPTS += -DZ3_BUILD_PYTHON_BINDINGS=OFF
endif

$(eval $(cmake-package))
