################################################################################
#
# python-itsdangerous
#
################################################################################

PYTHON_ITSDANGEROUS_VERSION = 2.0.1
PYTHON_ITSDANGEROUS_SOURCE = itsdangerous-$(PYTHON_ITSDANGEROUS_VERSION).tar.gz
PYTHON_ITSDANGEROUS_SITE = https://files.pythonhosted.org/packages/58/66/d6c5859dcac92b442626427a8c7a42322068c5cd5d4a463ce78b93f730b7
PYTHON_ITSDANGEROUS_SETUP_TYPE = setuptools
PYTHON_ITSDANGEROUS_LICENSE = BSD-3-Clause
PYTHON_ITSDANGEROUS_LICENSE_FILES = LICENSE.rst docs/license.rst

$(eval $(python-package))
