################################################################################
#
# ptm2human
#
################################################################################

PTM2HUMAN_VERSION = c8c5e7d5bdacd73114f4f244355e88c7f4e7d64a
PTM2HUMAN_SITE = $(call github,hwangcc23,ptm2human,$(PTM2HUMAN_VERSION))
PTM2HUMAN_LICENSE = GPL-2.0
PTM2HUMAN_LICENSE_FILES = LICENSE

# Straight out from an non-autoconfigured git tree:
PTM2HUMAN_AUTORECONF = YES

$(eval $(autotools-package))
