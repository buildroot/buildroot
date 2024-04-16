################################################################################
#
# python-pbr
#
################################################################################

PYTHON_PBR_VERSION = 6.0.0
PYTHON_PBR_SOURCE = pbr-$(PYTHON_PBR_VERSION).tar.gz
PYTHON_PBR_SITE = https://files.pythonhosted.org/packages/8d/c2/ee43b3b11bf2b40e56536183fc9f22afbb04e882720332b6276ee2454c24
PYTHON_PBR_SETUP_TYPE = setuptools
PYTHON_PBR_LICENSE = Apache-2.0 (module), BSD-3-Clause (test package)
PYTHON_PBR_LICENSE_FILES = LICENSE pbr/tests/testpackage/LICENSE.txt

$(eval $(host-python-package))
