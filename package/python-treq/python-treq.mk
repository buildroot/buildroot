################################################################################
#
# python-treq
#
################################################################################

PYTHON_TREQ_VERSION = 25.5.0
PYTHON_TREQ_SOURCE = treq-$(PYTHON_TREQ_VERSION).tar.gz
PYTHON_TREQ_SITE = https://files.pythonhosted.org/packages/ed/7b/b9dba8d947584481aad7e29b01f2ea6bbe794a0352e0cdb68e99ab135c31
PYTHON_TREQ_LICENSE = MIT
PYTHON_TREQ_LICENSE_FILES = LICENSE
PYTHON_TREQ_SETUP_TYPE = hatch
PYTHON_TREQ_DEPENDENCIES = host-python-incremental

$(eval $(python-package))
