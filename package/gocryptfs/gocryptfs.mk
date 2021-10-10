################################################################################
#
# gocryptfs
#
################################################################################

GOCRYPTFS_VERSION = 2.2.0
GOCRYPTFS_SITE = $(call github,rfjakob,gocryptfs,v$(GOCRYPTFS_VERSION))
GOCRYPTFS_LICENSE = MIT
GOCRYPTFS_LICENSE_FILES = LICENSE

GOCRYPTFS_GOMOD = github.com/rfjakob/gocryptfs/v2

GOCRYPTFS_LDFLAGS = \
	-X main.GitVersion=$(GOCRYPTFS_VERSION) \
	-X main.GitVersionFuse=[vendored]
GOCRYPTFS_TAGS = without_openssl

$(eval $(golang-package))
