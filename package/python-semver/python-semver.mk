################################################################################
#
# python-semver
#
################################################################################

PYTHON_SEMVER_VERSION = 3.0.2
PYTHON_SEMVER_SOURCE = semver-$(PYTHON_SEMVER_VERSION).tar.gz
PYTHON_SEMVER_SITE = https://files.pythonhosted.org/packages/41/6c/a536cc008f38fd83b3c1b98ce19ead13b746b5588c9a0cb9dd9f6ea434bc
PYTHON_SEMVER_SETUP_TYPE = setuptools
PYTHON_SEMVER_LICENSE = BSD-3-Clause
PYTHON_SEMVER_LICENSE_FILES = LICENSE.txt
PYTHON_SEMVER_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
