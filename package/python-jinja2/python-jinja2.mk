################################################################################
#
# python-jinja2
#
################################################################################

PYTHON_JINJA2_VERSION = 3.1.2
PYTHON_JINJA2_SOURCE = Jinja2-$(PYTHON_JINJA2_VERSION).tar.gz
PYTHON_JINJA2_SITE = https://files.pythonhosted.org/packages/7a/ff/75c28576a1d900e87eb6335b063fab47a8ef3c8b4d88524c4bf78f670cce
PYTHON_JINJA2_SETUP_TYPE = setuptools
PYTHON_JINJA2_LICENSE = BSD-3-Clause
PYTHON_JINJA2_LICENSE_FILES = LICENSE.rst
PYTHON_JINJA2_CPE_ID_VENDOR = pocoo
PYTHON_JINJA2_CPE_ID_PRODUCT = jinja2

# In host/target build, setup.py tries to download markupsafe if it is not installed
PYTHON_JINJA2_DEPENDENCIES = host-python-markupsafe
HOST_PYTHON_JINJA2_DEPENDENCIES = host-python-markupsafe

$(eval $(python-package))
$(eval $(host-python-package))
