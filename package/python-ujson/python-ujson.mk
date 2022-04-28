################################################################################
#
# python-ujson
#
################################################################################

PYTHON_UJSON_VERSION = 5.2.0
PYTHON_UJSON_SOURCE = ujson-$(PYTHON_UJSON_VERSION).tar.gz
PYTHON_UJSON_SITE = https://files.pythonhosted.org/packages/e4/fc/2dee0e78162aa1ad03dadde9a9b5c281d6f8bb0eed6810a270486d8fc041
PYTHON_UJSON_SETUP_TYPE = setuptools
PYTHON_UJSON_LICENSE = BSD-3-Clause
PYTHON_UJSON_LICENSE_FILES = LICENSE.txt
PYTHON_UJSON_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
