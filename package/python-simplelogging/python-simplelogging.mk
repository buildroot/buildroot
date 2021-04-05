################################################################################
#
# python-simplelogging
#
################################################################################

PYTHON_SIMPLELOGGING_VERSION = 0.11.0
PYTHON_SIMPLELOGGING_SOURCE = simplelogging-$(PYTHON_SIMPLELOGGING_VERSION).tar.gz
PYTHON_SIMPLELOGGING_SITE = https://files.pythonhosted.org/packages/73/d6/4c06aa7f2c3b9fc09429a1196fd357357cc555de5e16c09b2d12e9db1ebb
PYTHON_SIMPLELOGGING_SETUP_TYPE = setuptools
PYTHON_SIMPLELOGGING_LICENSE = BSD-3-Clause
PYTHON_SIMPLELOGGING_LICENSE_FILES = LICENSE

$(eval $(python-package))
