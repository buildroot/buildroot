################################################################################
#
# uqmi
#
################################################################################

UQMI_VERSION = 0a19b5b77140465c29e2afa7d611fe93abc9672f
UQMI_SITE = https://git.openwrt.org/project/uqmi.git
UQMI_SITE_METHOD = git
UQMI_LICENSE = LGPL-2.0+
UQMI_LICENSE_FILES = main.c
UQMI_DEPENDENCIES = json-c libubox

$(eval $(cmake-package))
