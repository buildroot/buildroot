################################################################################
#
# python-avro
#
################################################################################

# When updating the version, please also update avro-c
PYTHON_AVRO_VERSION = 1.12.0
PYTHON_AVRO_SOURCE = avro-$(PYTHON_AVRO_VERSION).tar.gz
PYTHON_AVRO_SITE = https://files.pythonhosted.org/packages/e6/73/48668732bbc8ae1e79b237f84e761204c8dd266c5e16e7601000aba471d3
PYTHON_AVRO_LICENSE = Apache-2.0
PYTHON_AVRO_LICENSE_FILES = avro/LICENSE
PYTHON_AVRO_SETUP_TYPE = setuptools

$(eval $(python-package))
