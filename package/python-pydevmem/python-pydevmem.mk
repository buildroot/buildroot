################################################################################
#
# python-pydevmem
#
################################################################################

PYTHON_PYDEVMEM_VERSION = 600b5d1ef8997c394db3512b735d75d5abc4ad41
PYTHON_PYDEVMEM_SITE = $(call github,kylemanna,pydevmem,$(PYTHON_PYDEVMEM_VERSION))
PYTHON_PYDEVMEM_SETUP_TYPE = setuptools
PYTHON_PYDEVMEM_LICENSE = MIT
PYTHON_PYDEVMEM_LICENSE_FILES = LICENSE

$(eval $(python-package))
