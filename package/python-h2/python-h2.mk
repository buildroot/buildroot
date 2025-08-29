################################################################################
#
# python-h2
#
################################################################################

PYTHON_H2_VERSION = 4.3.0
PYTHON_H2_SOURCE = h2-$(PYTHON_H2_VERSION).tar.gz
PYTHON_H2_SITE = https://files.pythonhosted.org/packages/1d/17/afa56379f94ad0fe8defd37d6eb3f89a25404ffc71d4d848893d270325fc
PYTHON_H2_SETUP_TYPE = setuptools
PYTHON_H2_LICENSE = MIT
PYTHON_H2_LICENSE_FILES = LICENSE

$(eval $(python-package))
