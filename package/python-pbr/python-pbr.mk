################################################################################
#
# python-pbr
#
################################################################################

PYTHON_PBR_VERSION = 5.6.0
PYTHON_PBR_SOURCE = pbr-$(PYTHON_PBR_VERSION).tar.gz
PYTHON_PBR_SITE = https://files.pythonhosted.org/packages/35/8c/69ed04ae31ad498c9bdea55766ed4c0c72de596e75ac0d70b58aa25e0acf
PYTHON_PBR_SETUP_TYPE = setuptools
PYTHON_PBR_LICENSE = Apache-2.0 (module), BSD-3-Clause (test package)
PYTHON_PBR_LICENSE_FILES = LICENSE pbr/tests/testpackage/LICENSE.txt

$(eval $(host-python-package))
