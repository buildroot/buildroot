################################################################################
#
# python-editables
#
################################################################################

PYTHON_EDITABLES_VERSION = 0.5
PYTHON_EDITABLES_SOURCE = editables-$(PYTHON_EDITABLES_VERSION).tar.gz
PYTHON_EDITABLES_SITE = https://files.pythonhosted.org/packages/37/4a/986d35164e2033ddfb44515168a281a7986e260d344cf369c3f52d4c3275
PYTHON_EDITABLES_LICENSE = MIT
PYTHON_EDITABLES_LICENSE_FILES = LICENSE.txt
PYTHON_EDITABLES_SETUP_TYPE = setuptools

$(eval $(host-python-package))
