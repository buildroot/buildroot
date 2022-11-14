################################################################################
#
# python-editables
#
################################################################################

PYTHON_EDITABLES_VERSION = 0.3
PYTHON_EDITABLES_SOURCE = editables-$(PYTHON_EDITABLES_VERSION).tar.gz
PYTHON_EDITABLES_SITE = https://files.pythonhosted.org/packages/01/b0/a2a87db4b6cb8e7d57004b6836faa634e0747e3e39ded126cdbe5a33ba36
PYTHON_EDITABLES_LICENSE = MIT
PYTHON_EDITABLES_LICENSE_FILES = LICENSE.txt
PYTHON_EDITABLES_SETUP_TYPE = setuptools

$(eval $(host-python-package))
