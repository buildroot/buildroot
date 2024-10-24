################################################################################
#
# python-pyhamcrest
#
################################################################################

PYTHON_PYHAMCREST_VERSION = 2.1.0
PYTHON_PYHAMCREST_SOURCE = pyhamcrest-$(PYTHON_PYHAMCREST_VERSION).tar.gz
PYTHON_PYHAMCREST_SITE = https://files.pythonhosted.org/packages/16/3f/f286caba4e64391a8dc9200e6de6ce0d07471e3f718248c3276843b7793b
PYTHON_PYHAMCREST_SETUP_TYPE = hatch
PYTHON_PYHAMCREST_LICENSE = BSD-3-Clause
PYTHON_PYHAMCREST_LICENSE_FILES = LICENSE.txt
PYTHON_PYHAMCREST_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
