################################################################################
#
# ripgrep
#
################################################################################

RIPGREP_VERSION = 14.1.0
RIPGREP_SITE = $(call github,burntsushi,ripgrep,$(RIPGREP_VERSION))
RIPGREP_LICENSE = MIT
RIPGREP_LICENSE_FILES = LICENSE-MIT
RIPGREP_CPE_ID_VALID = YES

# CVE only impacts ripgrep on Windows
RIPGREP_IGNORE_CVES += CVE-2021-3013

$(eval $(cargo-package))
