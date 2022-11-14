################################################################################
#
# python-h2
#
################################################################################

PYTHON_H2_VERSION = 4.1.0
PYTHON_H2_SOURCE = h2-$(PYTHON_H2_VERSION).tar.gz
PYTHON_H2_SITE = https://files.pythonhosted.org/packages/2a/32/fec683ddd10629ea4ea46d206752a95a2d8a48c22521edd70b142488efe1
PYTHON_H2_SETUP_TYPE = setuptools
PYTHON_H2_LICENSE = MIT
PYTHON_H2_LICENSE_FILES = LICENSE

$(eval $(python-package))
