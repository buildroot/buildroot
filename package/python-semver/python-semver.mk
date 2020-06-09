################################################################################
#
# python-semver
#
################################################################################

PYTHON_SEMVER_VERSION = 2.10.1
PYTHON_SEMVER_SOURCE = semver-$(PYTHON_SEMVER_VERSION).tar.gz
PYTHON_SEMVER_SITE = https://files.pythonhosted.org/packages/bc/82/5a9ee107810deb6cb142ea3b07aba619d6b6c0bd74c9e276b2b48b62696e
PYTHON_SEMVER_SETUP_TYPE = setuptools
PYTHON_SEMVER_LICENSE = BSD-3-Clause
PYTHON_SEMVER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
