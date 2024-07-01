################################################################################
#
# python-sniffio
#
################################################################################

PYTHON_SNIFFIO_VERSION = 1.3.1
PYTHON_SNIFFIO_SOURCE = sniffio-$(PYTHON_SNIFFIO_VERSION).tar.gz
PYTHON_SNIFFIO_SITE = https://files.pythonhosted.org/packages/a2/87/a6771e1546d97e7e041b6ae58d80074f81b7d5121207425c964ddf5cfdbd
PYTHON_SNIFFIO_SETUP_TYPE = setuptools
PYTHON_SNIFFIO_LICENSE = Apache-2.0 or MIT
PYTHON_SNIFFIO_LICENSE_FILES = LICENSE LICENSE.APACHE2 LICENSE.MIT
PYTHON_SNIFFIO_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
