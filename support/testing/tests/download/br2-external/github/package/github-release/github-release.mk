################################################################################
#
# github-release
#
################################################################################

GITHUB_RELEASE_VERSION = 233
GITHUB_RELEASE_SITE = https://github.com/systemd/systemd-bootchart/releases/download/v$(GITHUB_RELEASE_VERSION)
GITHUB_RELEASE_SOURCE = systemd-bootchart-$(GITHUB_RELEASE_VERSION).tar.xz
GITHUB_RELEASE_LICENSE_FILES = LICENSE.LGPL2.1

$(eval $(generic-package))
