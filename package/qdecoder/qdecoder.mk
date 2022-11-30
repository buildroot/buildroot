################################################################################
#
# qdecoder
#
################################################################################

QDECODER_VERSION = 12.1.0
QDECODER_SITE = $(call github,wolkykim,qdecoder,v$(QDECODER_VERSION))
QDECODER_LICENSE = BSD-2-Clause
QDECODER_LICENSE_FILES = COPYING
QDECODER_CPE_ID_VENDOR = qdecoder_project
QDECODER_CONF_ENV = ac_cv_prog_cc_c99='-std=gnu99'

QDECODER_INSTALL_STAGING = YES

$(eval $(autotools-package))
