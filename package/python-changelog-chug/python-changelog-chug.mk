################################################################################
#
# python-changelog-chug
#
################################################################################

PYTHON_CHANGELOG_CHUG_VERSION = 0.0.3
PYTHON_CHANGELOG_CHUG_SOURCE = changelog_chug-$(PYTHON_CHANGELOG_CHUG_VERSION).tar.gz
PYTHON_CHANGELOG_CHUG_SITE = https://files.pythonhosted.org/packages/fc/6d/f08e0f600f88c69923c692d486096ca7d2eae5d657516ec134fb45ed0ab0
PYTHON_CHANGELOG_CHUG_SETUP_TYPE = setuptools
PYTHON_CHANGELOG_CHUG_LICENSE = AGPL-3.0+
PYTHON_CHANGELOG_CHUG_LICENSE_FILES = COPYING
PYTHON_CHANGELOG_CHUG_DEPENDENCIES = host-python-semver host-python-docutils
HOST_PYTHON_CHANGELOG_CHUG_DEPENDENCIES = host-python-semver host-python-docutils

$(eval $(python-package))
$(eval $(host-python-package))
