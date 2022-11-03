################################################################################
#
# python-mako
#
################################################################################

PYTHON_MAKO_VERSION = 1.2.3
PYTHON_MAKO_SOURCE = Mako-$(PYTHON_MAKO_VERSION).tar.gz
PYTHON_MAKO_SITE = https://files.pythonhosted.org/packages/b9/38/c25f0874ea71802fc6f1e9f0f88a7e9666818121b28991bbc1d8eddbcdb1
PYTHON_MAKO_SETUP_TYPE = setuptools
PYTHON_MAKO_LICENSE = MIT
PYTHON_MAKO_LICENSE_FILES = LICENSE

# In host build, setup.py tries to download markupsafe if it is not installed
HOST_PYTHON_MAKO_DEPENDENCIES = host-python-markupsafe

$(eval $(python-package))
$(eval $(host-python-package))
