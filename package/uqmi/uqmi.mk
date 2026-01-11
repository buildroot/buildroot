################################################################################
#
# uqmi
#
################################################################################

UQMI_VERSION = 7914da43cddaaf6cfba116260c81e6e9adffd5ab
UQMI_SITE = https://git.openwrt.org/project/uqmi.git
UQMI_SITE_METHOD = git
UQMI_LICENSE = LGPL-2.0+
UQMI_LICENSE_FILES = uqmi/uqmi.c
UQMI_DEPENDENCIES = json-c libubox

$(eval $(cmake-package))
