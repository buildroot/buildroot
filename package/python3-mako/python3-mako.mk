################################################################################
#
# python3-mako
#
################################################################################

# Please keep in sync with
# package/python-mako/python-mako.mk
PYTHON3_MAKO_VERSION = 1.1.5
PYTHON3_MAKO_SOURCE = Mako-$(PYTHON3_MAKO_VERSION).tar.gz
PYTHON3_MAKO_SITE = https://files.pythonhosted.org/packages/d1/42/ff293411e980debfc647be9306d89840c8b82ea24571b014f1a35b2ad80f
PYTHON3_MAKO_SETUP_TYPE = setuptools
PYTHON3_MAKO_LICENSE = MIT
PYTHON3_MAKO_LICENSE_FILES = LICENSE
HOST_PYTHON3_MAKO_DL_SUBDIR = python-mako
HOST_PYTHON3_MAKO_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
