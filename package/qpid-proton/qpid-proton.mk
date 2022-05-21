################################################################################
#
# qpid-proton
#
################################################################################

QPID_PROTON_VERSION = 0.35.0
QPID_PROTON_SITE = \
	https://downloads.apache.org/qpid/proton/$(QPID_PROTON_VERSION)
QPID_PROTON_LICENSE = Apache-2.0
QPID_PROTON_LICENSE_FILES = LICENSE.txt
QPID_PROTON_CPE_ID_VENDOR = apache
QPID_PROTON_CPE_ID_PRODUCT = qpid_proton
QPID_PROTON_INSTALL_STAGING = YES
QPID_PROTON_DEPENDENCIES = \
	host-python3 \
	util-linux \
	$(if $(BR2_PACKAGE_LIBUV),libuv) \
	$(if $(BR2_PACKAGE_OPENSSL),openssl)

# python and ruby language bindings are enabled when host-swig tool is present
# in HOST_DIR.
# go language binding is enabled when host-go is present
# For now, disable all of them.
QPID_PROTON_CONF_OPTS = \
	-DBUILD_CPP=ON \
	-DBUILD_GO=OFF \
	-DBUILD_PYTHON=OFF \
	-DBUILD_RUBY=OFF \
	-DENABLE_FUZZ_TESTING=OFF \
	-DENABLE_VALGRIND=OFF \
	-DENABLE_WARNING_ERROR=OFF \
	-DPYTHON_EXECUTABLE=$(HOST_DIR)/bin/python3

ifeq ($(BR2_PACKAGE_JSONCPP),y)
QPID_PROTON_DEPENDENCIES += jsoncpp
QPID_PROTON_CONF_OPTS += -DENABLE_JSONCPP=ON
else
QPID_PROTON_CONF_OPTS += -DENABLE_JSONCPP=OFF
endif

define QPID_PROTON_REMOVE_USELESS_FILES
	rm -fr $(TARGET_DIR)/usr/share/proton/
endef

QPID_PROTON_POST_INSTALL_TARGET_HOOKS += QPID_PROTON_REMOVE_USELESS_FILES

$(eval $(cmake-package))
