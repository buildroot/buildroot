################################################################################
#
# python-trove-classifiers
#
################################################################################

PYTHON_TROVE_CLASSIFIERS_VERSION = 2024.9.12
PYTHON_TROVE_CLASSIFIERS_SOURCE = trove_classifiers-$(PYTHON_TROVE_CLASSIFIERS_VERSION).tar.gz
PYTHON_TROVE_CLASSIFIERS_SITE = https://files.pythonhosted.org/packages/16/14/55ceb59dabf95f554b5368fdabe8d370165a25f817a23d809ad6c87a0b06
PYTHON_TROVE_CLASSIFIERS_SETUP_TYPE = setuptools
PYTHON_TROVE_CLASSIFIERS_LICENSE = Apache-2.0
PYTHON_TROVE_CLASSIFIERS_LICENSE_FILES = LICENSE
HOST_PYTHON_TROVE_CLASSIFIERS_DEPENDENCIES = host-python-calver

$(eval $(host-python-package))
