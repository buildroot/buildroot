################################################################################
#
# python-truststore
#
################################################################################

PYTHON_TRUSTSTORE_VERSION = 0.10.4
PYTHON_TRUSTSTORE_SOURCE = truststore-$(PYTHON_TRUSTSTORE_VERSION).tar.gz
PYTHON_TRUSTSTORE_SITE = https://files.pythonhosted.org/packages/53/a3/1585216310e344e8102c22482f6060c7a6ea0322b63e026372e6dcefcfd6
PYTHON_TRUSTSTORE_SETUP_TYPE = flit
PYTHON_TRUSTSTORE_LICENSE = MIT
PYTHON_TRUSTSTORE_LICENSE_FILES = LICENSE

$(eval $(python-package))
