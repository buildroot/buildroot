################################################################################
#
# libcorrect
#
################################################################################

LIBCORRECT_VERSION = f5a28c74fba7a99736fe49d3a5243eca29517ae9
LIBCORRECT_SITE = $(call github,quiet,libcorrect,$(LIBCORRECT_VERSION))
LIBCORRECT_LICENSE = BSD-3-Clause
LIBCORRECT_LICENSE_FILES = LICENSE
LIBCORRECT_INSTALL_STAGING = YES

$(eval $(cmake-package))
