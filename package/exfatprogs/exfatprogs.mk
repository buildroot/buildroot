################################################################################
#
# exfatprogs
#
################################################################################

EXFATPROGS_VERSION = 1.1.3
EXFATPROGS_SOURCE = exfatprogs-$(EXFATPROGS_VERSION).tar.xz
EXFATPROGS_SITE = https://github.com/exfatprogs/exfatprogs/releases/download/$(EXFATPROGS_VERSION)
EXFATPROGS_LICENSE = GPL-2.0+
EXFATPROGS_LICENSE_FILES = COPYING

$(eval $(autotools-package))
$(eval $(host-autotools-package))
