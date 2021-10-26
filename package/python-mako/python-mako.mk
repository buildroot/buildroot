################################################################################
#
# python-mako
#
################################################################################

PYTHON_MAKO_VERSION = 1.1.5
PYTHON_MAKO_SOURCE = Mako-$(PYTHON_MAKO_VERSION).tar.gz
PYTHON_MAKO_SITE = https://files.pythonhosted.org/packages/d1/42/ff293411e980debfc647be9306d89840c8b82ea24571b014f1a35b2ad80f
PYTHON_MAKO_SETUP_TYPE = setuptools
PYTHON_MAKO_LICENSE = MIT
PYTHON_MAKO_LICENSE_FILES = LICENSE

HOST_PYTHON_MAKO_NEEDS_HOST_PYTHON = python3

# In host build, setup.py tries to download markupsafe if it is not installed
HOST_PYTHON_MAKO_DEPENDENCIES = host-python-markupsafe

$(eval $(python-package))
$(eval $(host-python-package))
