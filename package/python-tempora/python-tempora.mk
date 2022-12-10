################################################################################
#
# python-tempora
#
################################################################################

PYTHON_TEMPORA_VERSION = 5.1.0
PYTHON_TEMPORA_SOURCE = tempora-$(PYTHON_TEMPORA_VERSION).tar.gz
PYTHON_TEMPORA_SITE = https://files.pythonhosted.org/packages/a9/4e/41863232e77742b3a5b30a81e1398abd102aa0a67657bc86a53800966b8e
PYTHON_TEMPORA_LICENSE = MIT
PYTHON_TEMPORA_LICENSE_FILES = LICENSE
PYTHON_TEMPORA_SETUP_TYPE = setuptools
PYTHON_TEMPORA_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
