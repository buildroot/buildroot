################################################################################
#
# python-idna
#
################################################################################

PYTHON_IDNA_VERSION = 3.20
PYTHON_IDNA_SOURCE = idna-$(PYTHON_IDNA_VERSION).tar.gz
PYTHON_IDNA_SITE = https://files.pythonhosted.org/packages/f5/08/8eea9d4b8302028f3abb2c0813953f7aec26d33b7a8960ed760e65ff29fa
PYTHON_IDNA_LICENSE = BSD-3-Clause
PYTHON_IDNA_LICENSE_FILES = LICENSE.md
PYTHON_IDNA_SETUP_TYPE = flit

$(eval $(python-package))
$(eval $(host-python-package))
