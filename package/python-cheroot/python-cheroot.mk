################################################################################
#
# python-cheroot
#
################################################################################

PYTHON_CHEROOT_VERSION = 9.0.0
PYTHON_CHEROOT_SOURCE = cheroot-$(PYTHON_CHEROOT_VERSION).tar.gz
PYTHON_CHEROOT_SITE = https://files.pythonhosted.org/packages/8c/e7/8e6387d59a352c5799e917a23e7b76771a8bb97322c1ce7e42934d0066c3
PYTHON_CHEROOT_LICENSE = BSD-3-Clause
PYTHON_CHEROOT_LICENSE_FILES = LICENSE.md
PYTHON_CHEROOT_SETUP_TYPE = setuptools
PYTHON_CHEROOT_DEPENDENCIES = host-python-setuptools-scm host-python-setuptools-scm-git-archive

$(eval $(python-package))
