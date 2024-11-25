################################################################################
#
# python-itsdangerous
#
################################################################################

PYTHON_ITSDANGEROUS_VERSION = 2.2.0
PYTHON_ITSDANGEROUS_SOURCE = itsdangerous-$(PYTHON_ITSDANGEROUS_VERSION).tar.gz
PYTHON_ITSDANGEROUS_SITE = https://files.pythonhosted.org/packages/9c/cb/8ac0172223afbccb63986cc25049b154ecfb5e85932587206f42317be31d
PYTHON_ITSDANGEROUS_SETUP_TYPE = flit
PYTHON_ITSDANGEROUS_LICENSE = BSD-3-Clause
PYTHON_ITSDANGEROUS_LICENSE_FILES = LICENSE.txt docs/license.rst

$(eval $(python-package))
