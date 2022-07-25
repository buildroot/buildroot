################################################################################
#
# hyperfine
#
################################################################################

HYPERFINE_VERSION = 1.14.0
HYPERFINE_SITE = $(call github,sharkdp,hyperfine,v$(HYPERFINE_VERSION))
HYPERFINE_LICENSE = Apache-2.0 or MIT
HYPERFINE_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT

$(eval $(cargo-package))
