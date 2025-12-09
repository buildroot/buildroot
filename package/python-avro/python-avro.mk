################################################################################
#
# python-avro
#
################################################################################

# When updating the version, please also update avro-c
PYTHON_AVRO_VERSION = 1.12.1
PYTHON_AVRO_SOURCE = avro-$(PYTHON_AVRO_VERSION).tar.gz
PYTHON_AVRO_SITE = https://files.pythonhosted.org/packages/60/00/af1eec633637e12d0945a97f05a429eed83ac45865af60cb453db4689d95
PYTHON_AVRO_LICENSE = Apache-2.0
PYTHON_AVRO_LICENSE_FILES = avro/LICENSE
PYTHON_AVRO_SETUP_TYPE = setuptools

$(eval $(python-package))
