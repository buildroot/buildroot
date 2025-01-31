################################################################################
#
# procs
#
################################################################################

PROCS_VERSION = 0.14.9
PROCS_SITE = $(call github,dalance,procs,v$(PROCS_VERSION))
PROCS_LICENSE = MIT
PROCS_LICENSE_FILES = LICENSE

$(eval $(cargo-package))
