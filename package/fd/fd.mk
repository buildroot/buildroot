################################################################################
#
# fd
#
################################################################################

FD_VERSION = 10.2.0
FD_SITE = $(call github,sharkdp,fd,v$(FD_VERSION))
FD_LICENSE = Apache-2.0 or MIT
FD_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT

$(eval $(cargo-package))
