################################################################################
#
# python-pydal
#
################################################################################

PYTHON_PYDAL_VERSION = 20250629.2
PYTHON_PYDAL_SOURCE = pydal-$(PYTHON_PYDAL_VERSION).tar.gz
PYTHON_PYDAL_SITE = https://files.pythonhosted.org/packages/43/9b/a4ec4f0970259b873ee6ea66cfd7681436aa3dff814aa1ad589315a6a4a6
PYTHON_PYDAL_LICENSE = BSD-3-Clause
PYTHON_PYDAL_LICENSE_FILES = LICENSE.txt
PYTHON_PYDAL_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
