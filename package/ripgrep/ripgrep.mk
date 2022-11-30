################################################################################
#
# ripgrep
#
################################################################################

# Same as 13.0.0, we use a Git commit hash because the hash of this
# tarball changed when moving to the cargo-package infrastructure, and
# we can't change the hash of existing tarball. Please switch back to
# a Git tag at the next version bump.
RIPGREP_VERSION = af6b6c543b224d348a8876f0c06245d9ea7929c5
RIPGREP_SITE = $(call github,burntsushi,ripgrep,$(RIPGREP_VERSION))
RIPGREP_LICENSE = MIT
RIPGREP_LICENSE_FILES = LICENSE-MIT
RIPGREP_CPE_ID_VENDOR = ripgrep_project

# CVE only impacts ripgrep on Windows
RIPGREP_IGNORE_CVES += CVE-2021-3013

$(eval $(cargo-package))
