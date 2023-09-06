################################################################################
#
# libiec61850
#
################################################################################

LIBIEC61850_VERSION = 1.5.1
LIBIEC61850_SITE = https://libiec61850.com/wp-content/uploads/2022/03
LIBIEC61850_INSTALL_STAGING = YES
LIBIEC61850_LICENSE = GPL-3.0+
LIBIEC61850_LICENSE_FILES = COPYING
LIBIEC61850_CPE_ID_VENDOR = mz-automation
LIBIEC61850_CONF_OPTS = -DBUILD_PYTHON_BINDINGS=OFF
# Examples aren't build
# https://github.com/mz-automation/libiec61850/issues/442
LIBIEC61850_IGNORE_CVES += CVE-2023-27772

$(eval $(cmake-package))
