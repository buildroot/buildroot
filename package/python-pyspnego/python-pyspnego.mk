################################################################################
#
# python-pyspnego
#
################################################################################

PYTHON_PYSPNEGO_VERSION = 0.12.1
PYTHON_PYSPNEGO_SOURCE = pyspnego-$(PYTHON_PYSPNEGO_VERSION).tar.gz
PYTHON_PYSPNEGO_SITE = https://files.pythonhosted.org/packages/7d/84/58577bd1b14293650879de0579ec263a1d8350f1d6d227226cf776b5a6a6
PYTHON_PYSPNEGO_SETUP_TYPE = setuptools
PYTHON_PYSPNEGO_LICENSE = MIT
PYTHON_PYSPNEGO_LICENSE_FILES = LICENSE

$(eval $(python-package))
