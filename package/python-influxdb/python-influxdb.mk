################################################################################
#
# python-influxdb
#
################################################################################

PYTHON_INFLUXDB_VERSION = 5.3.2
PYTHON_INFLUXDB_SOURCE = influxdb-$(PYTHON_INFLUXDB_VERSION).tar.gz
PYTHON_INFLUXDB_SITE = https://files.pythonhosted.org/packages/12/d4/4c1bd3a8f85403fad3137a7e44f7882b0366586b7c27d12713493516f1c7
PYTHON_INFLUXDB_SETUP_TYPE = setuptools
PYTHON_INFLUXDB_LICENSE = MIT
PYTHON_INFLUXDB_LICENSE_FILES = LICENSE

$(eval $(python-package))
