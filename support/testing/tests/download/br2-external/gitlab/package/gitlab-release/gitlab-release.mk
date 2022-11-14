################################################################################
#
# gitlab-release
#
################################################################################

GITLAB_RELEASE_VERSION = 2.3.1
GITLAB_RELEASE_SITE = https://gitlab.com/iucode-tool/releases/raw/master
GITLAB_RELEASE_SOURCE = iucode-tool_$(GITLAB_RELEASE_VERSION).tar.xz
GITLAB_RELEASE_LICENSE_FILES = COPYING

$(eval $(generic-package))
