################################################################################
#
# orc
#
################################################################################

ORC_VERSION = 0.4.34
ORC_SOURCE = orc-$(ORC_VERSION).tar.xz
ORC_SITE = http://gstreamer.freedesktop.org/data/src/orc
ORC_LICENSE = BSD-2-Clause, BSD-3-Clause
ORC_LICENSE_FILES = COPYING
ORC_CPE_ID_VENDOR = gstreamer
ORC_INSTALL_STAGING = YES
ORC_DEPENDENCIES = host-orc
ORC_CONF_OPTS = \
	-Dbenchmarks=disabled \
	-Dexamples=disabled \
	-Dgtk_doc=disabled \
	-Dorc-test=disabled \
	-Dtests=disabled \
	-Dtools=disabled

# 0001-use-vasprintf-if-available-for-error-messages-and-otherwise-vsnprintf.patch
ORC_IGNORE_CVES += CVE-2024-40897

$(eval $(meson-package))
$(eval $(host-meson-package))
