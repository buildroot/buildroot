################################################################################
#
# python-cheroot
#
################################################################################

PYTHON_CHEROOT_VERSION = 8.6.0
PYTHON_CHEROOT_SOURCE = cheroot-$(PYTHON_CHEROOT_VERSION).tar.gz
PYTHON_CHEROOT_SITE = https://files.pythonhosted.org/packages/99/c4/9b5ca09208047f2689c24ee63e195aa01ceffb7857d715cabc046559ddd6
PYTHON_CHEROOT_LICENSE = BSD-3-Clause
PYTHON_CHEROOT_LICENSE_FILES = LICENSE.md
PYTHON_CHEROOT_SETUP_TYPE = setuptools
PYTHON_CHEROOT_DEPENDENCIES = host-python-setuptools-scm host-python-setuptools-scm-git-archive

$(eval $(python-package))
