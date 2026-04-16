################################################################################
#
# python-libyang
#
################################################################################

PYTHON_LIBYANG_VERSION = 3.3.0
PYTHON_LIBYANG_SOURCE = libyang-$(PYTHON_LIBYANG_VERSION).tar.gz
PYTHON_LIBYANG_SITE = https://files.pythonhosted.org/packages/source/l/libyang

PYTHON_LIBYANG_LICENSE = MIT
PYTHON_LIBYANG_LICENSE_FILES = LICENSE

# pyproject.toml (PEP517)
PYTHON_LIBYANG_SETUP_TYPE = pep517

PYTHON_LIBYANG_DEPENDENCIES = \
	libyang \
	host-python-cffi

$(eval $(python-package))
