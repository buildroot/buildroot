################################################################################
#
# python-avro
#
################################################################################

# When updating the version, please also update avro-c
PYTHON_AVRO_VERSION = 1.12.2
PYTHON_AVRO_SOURCE = avro-$(PYTHON_AVRO_VERSION).tar.gz
PYTHON_AVRO_SITE = https://files.pythonhosted.org/packages/5f/68/973b9c682aa2c3cf2b05fc4c961af11b9be1d9b46604f65aed23cd4fd1e6
PYTHON_AVRO_LICENSE = Apache-2.0
PYTHON_AVRO_LICENSE_FILES = avro/LICENSE
PYTHON_AVRO_SETUP_TYPE = setuptools

$(eval $(python-package))
