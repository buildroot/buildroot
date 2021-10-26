################################################################################
#
# python-jinja2
#
################################################################################

PYTHON_JINJA2_VERSION = 3.0.2
PYTHON_JINJA2_SOURCE = Jinja2-$(PYTHON_JINJA2_VERSION).tar.gz
PYTHON_JINJA2_SITE = https://files.pythonhosted.org/packages/f8/86/7c0eb6e8b05385d1ce682abc0f994abd1668e148fb52603fa86e15d4c110
PYTHON_JINJA2_SETUP_TYPE = setuptools
PYTHON_JINJA2_LICENSE = BSD-3-Clause
PYTHON_JINJA2_LICENSE_FILES = LICENSE.rst
PYTHON_JINJA2_CPE_ID_VENDOR = pocoo
PYTHON_JINJA2_CPE_ID_PRODUCT = jinja2

# In host/target build, setup.py tries to download markupsafe if it is not installed
PYTHON_JINJA2_DEPENDENCIES = host-python-markupsafe
HOST_PYTHON_JINJA2_DEPENDENCIES = host-python-markupsafe

HOST_PYTHON_JINJA2_NEEDS_HOST_PYTHON = python3

$(eval $(python-package))
$(eval $(host-python-package))
