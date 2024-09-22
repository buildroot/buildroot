################################################################################
#
# python-wtforms
#
################################################################################

PYTHON_WTFORMS_VERSION = 3.1.2
PYTHON_WTFORMS_SOURCE = wtforms-$(PYTHON_WTFORMS_VERSION).tar.gz
PYTHON_WTFORMS_SITE = https://files.pythonhosted.org/packages/6a/c7/96d10183c3470f1836846f7b9527d6cb0b6c2226ebca40f36fa29f23de60
PYTHON_WTFORMS_SETUP_TYPE = pep517
PYTHON_WTFORMS_LICENSE = BSD-3-Clause
PYTHON_WTFORMS_LICENSE_FILES = LICENSE.rst docs/license.rst
PYTHON_WTFORMS_DEPENDENCIES = host-python-babel host-python-hatchling

$(eval $(python-package))
