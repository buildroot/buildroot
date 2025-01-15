################################################################################
#
# python-jinja2
#
################################################################################

PYTHON_JINJA2_VERSION = 3.1.5
PYTHON_JINJA2_SOURCE = jinja2-$(PYTHON_JINJA2_VERSION).tar.gz
PYTHON_JINJA2_SITE = https://files.pythonhosted.org/packages/af/92/b3130cbbf5591acf9ade8708c365f3238046ac7cb8ccba6e81abccb0ccff
PYTHON_JINJA2_SETUP_TYPE = flit
PYTHON_JINJA2_LICENSE = BSD-3-Clause
PYTHON_JINJA2_LICENSE_FILES = LICENSE.txt
PYTHON_JINJA2_CPE_ID_VENDOR = pocoo
PYTHON_JINJA2_CPE_ID_PRODUCT = jinja2

# In host/target build, setup.py tries to download markupsafe if it is not installed
PYTHON_JINJA2_DEPENDENCIES = host-python-markupsafe
HOST_PYTHON_JINJA2_DEPENDENCIES = host-python-markupsafe

$(eval $(python-package))
$(eval $(host-python-package))
