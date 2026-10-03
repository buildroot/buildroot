################################################################################
#
# python-semver
#
################################################################################

PYTHON_SEMVER_VERSION = 3.1.0
PYTHON_SEMVER_SOURCE = semver-$(PYTHON_SEMVER_VERSION).tar.gz
PYTHON_SEMVER_SITE = https://files.pythonhosted.org/packages/92/f5/e1dfe8e1d91c54ce212fd93916eb01fd1c590f413be0a0978c39a97aa1bb
PYTHON_SEMVER_SETUP_TYPE = setuptools
PYTHON_SEMVER_LICENSE = BSD-3-Clause
PYTHON_SEMVER_LICENSE_FILES = LICENSE.txt
PYTHON_SEMVER_DEPENDENCIES = host-python-setuptools-scm
HOST_PYTHON_SEMVER_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
$(eval $(host-python-package))
