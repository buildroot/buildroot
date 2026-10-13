################################################################################
#
# python-truststore
#
################################################################################

PYTHON_TRUSTSTORE_VERSION = 0.10.5
PYTHON_TRUSTSTORE_SOURCE = truststore-$(PYTHON_TRUSTSTORE_VERSION).tar.gz
PYTHON_TRUSTSTORE_SITE = https://files.pythonhosted.org/packages/ee/9f/c5201d42a484c061e528825fc8e2d565f5abd50a4ced6fb7d29c4ec99b2b
PYTHON_TRUSTSTORE_SETUP_TYPE = flit
PYTHON_TRUSTSTORE_LICENSE = MIT
PYTHON_TRUSTSTORE_LICENSE_FILES = LICENSE

$(eval $(python-package))
