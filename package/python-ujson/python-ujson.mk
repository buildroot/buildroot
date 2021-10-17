################################################################################
#
# python-ujson
#
################################################################################

PYTHON_UJSON_VERSION = 4.2.0
PYTHON_UJSON_SOURCE = ujson-$(PYTHON_UJSON_VERSION).tar.gz
PYTHON_UJSON_SITE = https://files.pythonhosted.org/packages/df/69/e8f615e1a779e2d2d23d29d56dc55bbb1db2a828f0ef36d10bc697d63968
PYTHON_UJSON_SETUP_TYPE = setuptools
PYTHON_UJSON_LICENSE = BSD-3-Clause
PYTHON_UJSON_LICENSE_FILES = LICENSE.txt
PYTHON_UJSON_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
