################################################################################
#
# gemmlowp
#
################################################################################

GEMMLOWP_VERSION = 16e8662c34917be0065110bfcd9cc27d30f52fdf
GEMMLOWP_SITE = $(call github,google,gemmlowp,$(GEMMLOWP_VERSION))
GEMMLOWP_LICENSE = Apache-2.0
GEMMLOWP_LICENSE_FILES = LICENSE
GEMMLOWP_INSTALL_STAGING = YES
# Only installs a header
GEMMLOWP_INSTALL_TARGET = NO
GEMMLOWP_SUBDIR = contrib

$(eval $(cmake-package))
