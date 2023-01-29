################################################################################
#
# python-sniffio
#
################################################################################

PYTHON_SNIFFIO_VERSION = 1.3.0
PYTHON_SNIFFIO_SOURCE = sniffio-$(PYTHON_SNIFFIO_VERSION).tar.gz
PYTHON_SNIFFIO_SITE = https://files.pythonhosted.org/packages/cd/50/d49c388cae4ec10e8109b1b833fd265511840706808576df3ada99ecb0ac
PYTHON_SNIFFIO_SETUP_TYPE = setuptools
PYTHON_SNIFFIO_LICENSE = Apache-2.0 or MIT
PYTHON_SNIFFIO_LICENSE_FILES = LICENSE LICENSE.APACHE2 LICENSE.MIT

$(eval $(python-package))
