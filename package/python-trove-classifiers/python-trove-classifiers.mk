################################################################################
#
# python-trove-classifiers
#
################################################################################

PYTHON_TROVE_CLASSIFIERS_VERSION = 2024.10.21.16
PYTHON_TROVE_CLASSIFIERS_SOURCE = trove_classifiers-$(PYTHON_TROVE_CLASSIFIERS_VERSION).tar.gz
PYTHON_TROVE_CLASSIFIERS_SITE = https://files.pythonhosted.org/packages/99/85/92c2667cf221b37648041ce9319427f92fa76cbec634aad844e67e284706
PYTHON_TROVE_CLASSIFIERS_SETUP_TYPE = setuptools
PYTHON_TROVE_CLASSIFIERS_LICENSE = Apache-2.0
PYTHON_TROVE_CLASSIFIERS_LICENSE_FILES = LICENSE
HOST_PYTHON_TROVE_CLASSIFIERS_DEPENDENCIES = host-python-calver

$(eval $(host-python-package))
