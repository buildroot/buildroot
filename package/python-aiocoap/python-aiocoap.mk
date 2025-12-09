################################################################################
#
# python-aiocoap
#
################################################################################

PYTHON_AIOCOAP_VERSION = 0.4.17
PYTHON_AIOCOAP_SOURCE = aiocoap-$(PYTHON_AIOCOAP_VERSION).tar.gz
PYTHON_AIOCOAP_SITE = https://files.pythonhosted.org/packages/1d/7c/10483df04d7910e21d55d47ab7c014fb02644b5b58ba741161360f8e9e8d
PYTHON_AIOCOAP_SETUP_TYPE = setuptools
PYTHON_AIOCOAP_LICENSE = BSD-3-Clause, MIT
PYTHON_AIOCOAP_LICENSE_FILES = doc/LICENSE.rst LICENSES/BSD-3-Clause.txt LICENSES/MIT.txt

$(eval $(python-package))
