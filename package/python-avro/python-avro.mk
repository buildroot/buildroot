################################################################################
#
# python-avro
#
################################################################################

# When updating the version, please also update avro-c
PYTHON_AVRO_VERSION = 1.11.0
PYTHON_AVRO_SITE = \
	https://www-eu.apache.org/dist/avro/avro-$(PYTHON_AVRO_VERSION)/py
PYTHON_AVRO_SOURCE = avro-$(PYTHON_AVRO_VERSION).tar.gz
PYTHON_AVRO_LICENSE = Apache-2.0
PYTHON_AVRO_LICENSE_FILES = avro/LICENSE
PYTHON_AVRO_SETUP_TYPE = setuptools

$(eval $(python-package))
