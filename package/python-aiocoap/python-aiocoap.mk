################################################################################
#
# python-aiocoap
#
################################################################################

PYTHON_AIOCOAP_VERSION = 0.4.11
PYTHON_AIOCOAP_SOURCE = aiocoap-$(PYTHON_AIOCOAP_VERSION).tar.gz
PYTHON_AIOCOAP_SITE = https://files.pythonhosted.org/packages/50/b3/2ea6d3a294ec094da3175aceaa2ad1c2644eab162b48676267e992d4c651
PYTHON_AIOCOAP_SETUP_TYPE = setuptools
PYTHON_AIOCOAP_LICENSE = BSD-3-Clause, MIT
PYTHON_AIOCOAP_LICENSE_FILES = doc/LICENSE.rst LICENSES/BSD-3-Clause.txt LICENSES/MIT.txt

$(eval $(python-package))
