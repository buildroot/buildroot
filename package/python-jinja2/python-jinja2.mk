################################################################################
#
# python-jinja2
#
################################################################################

PYTHON_JINJA2_VERSION = 3.1.4
PYTHON_JINJA2_SOURCE = jinja2-$(PYTHON_JINJA2_VERSION).tar.gz
PYTHON_JINJA2_SITE = https://files.pythonhosted.org/packages/ed/55/39036716d19cab0747a5020fc7e907f362fbf48c984b14e62127f7e68e5d
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
