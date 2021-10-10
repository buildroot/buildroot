################################################################################
#
# python-semver
#
################################################################################

PYTHON_SEMVER_VERSION = 2.13.0
PYTHON_SEMVER_SOURCE = semver-$(PYTHON_SEMVER_VERSION).tar.gz
PYTHON_SEMVER_SITE = https://files.pythonhosted.org/packages/31/a9/b61190916030ee9af83de342e101f192bbb436c59be20a4cb0cdb7256ece
PYTHON_SEMVER_SETUP_TYPE = setuptools
PYTHON_SEMVER_LICENSE = BSD-3-Clause
PYTHON_SEMVER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
