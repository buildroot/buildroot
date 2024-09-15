################################################################################
#
# python-cheroot
#
################################################################################

PYTHON_CHEROOT_VERSION = 10.0.1
PYTHON_CHEROOT_SOURCE = cheroot-$(PYTHON_CHEROOT_VERSION).tar.gz
PYTHON_CHEROOT_SITE = https://files.pythonhosted.org/packages/63/e2/f85981a51281bd30525bf664309332faa7c81782bb49e331af603421dbd1
PYTHON_CHEROOT_LICENSE = BSD-3-Clause
PYTHON_CHEROOT_LICENSE_FILES = LICENSE.md
PYTHON_CHEROOT_SETUP_TYPE = setuptools
PYTHON_CHEROOT_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
