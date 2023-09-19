################################################################################
#
# opensc
#
################################################################################

OPENSC_VERSION = 0.22.0
OPENSC_SITE = https://github.com/OpenSC/OpenSC/releases/download/$(OPENSC_VERSION)
OPENSC_LICENSE = LGPL-2.1+
OPENSC_LICENSE_FILES = COPYING
OPENSC_CPE_ID_VENDOR = opensc_project
OPENSC_DEPENDENCIES = openssl pcsc-lite
OPENSC_INSTALL_STAGING = YES
OPENSC_CONF_OPTS = --disable-cmocka --disable-strict

# 0004-pkcs15init-correct-left-length-calculation-to-fix-buffer-overrun-bug.patch
OPENSC_IGNORE_CVES += CVE-2023-2977

$(eval $(autotools-package))
