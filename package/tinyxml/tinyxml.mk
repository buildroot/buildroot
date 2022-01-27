################################################################################
#
# tinyxml
#
################################################################################

TINYXML_VERSION = 2.6.2_2
TINYXML_SITE = http://mirrors.xbmc.org/build-deps/sources
# AUTORECONF is needed because the XBMC's version of TinyXML contains a
# configure.ac which is not present in mainline.
TINYXML_AUTORECONF = YES
TINYXML_INSTALL_STAGING = YES
TINYXML_LICENSE = Zlib
TINYXML_LICENSE_FILES = README
TINYXML_CPE_ID_VENDOT = tinyxml_project

# 0001-In-stamp-always-advance-the-pointer-if-p-0xef.patch
TINYXML_IGNORE_CVES += CVE-2021-42260

$(eval $(autotools-package))
