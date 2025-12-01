################################################################################
#
# yq
#
################################################################################

YQ_VERSION = 4.49.2
YQ_SITE = $(call github,mikefarah,yq,v$(YQ_VERSION))
YQ_LICENSE = MIT
YQ_LICENSE_FILES = LICENSE
YQ_GOMOD = github.com/mikefarah/yq/v4

$(eval $(golang-package))
