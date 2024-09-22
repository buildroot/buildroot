################################################################################
#
# python-zeroconf
#
################################################################################

PYTHON_ZEROCONF_VERSION = 0.123.0
PYTHON_ZEROCONF_SOURCE = zeroconf-$(PYTHON_ZEROCONF_VERSION).tar.gz
PYTHON_ZEROCONF_SITE = https://files.pythonhosted.org/packages/db/47/85eafb277f6ef78e1a1895cc72f0035dfa6a5e51396134eb9ce21564c72f
PYTHON_ZEROCONF_SETUP_TYPE = pep517
PYTHON_ZEROCONF_LICENSE = LGPL-2.1+
PYTHON_ZEROCONF_LICENSE_FILES = COPYING
PYTHON_ZEROCONF_DEPENDENCIES = \
	host-python-cython \
	host-python-poetry-core \
	host-python-setuptools

$(eval $(python-package))
