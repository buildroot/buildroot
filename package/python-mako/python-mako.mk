################################################################################
#
# python-mako
#
################################################################################

PYTHON_MAKO_VERSION = 1.3.10
PYTHON_MAKO_SOURCE = mako-$(PYTHON_MAKO_VERSION).tar.gz
PYTHON_MAKO_SITE = https://files.pythonhosted.org/packages/9e/38/bd5b78a920a64d708fe6bc8e0a2c075e1389d53bef8413725c63ba041535
PYTHON_MAKO_SETUP_TYPE = setuptools
PYTHON_MAKO_LICENSE = MIT
PYTHON_MAKO_LICENSE_FILES = LICENSE
PYTHON_MAKO_CPE_ID_VENDOR = sqlalchemy
PYTHON_MAKO_CPE_ID_PRODUCT = mako

# In host build, setup.py tries to download markupsafe if it is not installed
HOST_PYTHON_MAKO_DEPENDENCIES = host-python-markupsafe

$(eval $(python-package))
$(eval $(host-python-package))
