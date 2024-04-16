################################################################################
#
# python-influxdb
#
################################################################################

PYTHON_INFLUXDB_VERSION = 5.3.1
PYTHON_INFLUXDB_SOURCE = influxdb-$(PYTHON_INFLUXDB_VERSION).tar.gz
PYTHON_INFLUXDB_SITE = https://files.pythonhosted.org/packages/86/4f/a9c524576677c1694b149e09d4fd6342e4a1d9a5f409e437168a14d6d150
PYTHON_INFLUXDB_SETUP_TYPE = setuptools
PYTHON_INFLUXDB_LICENSE = MIT
PYTHON_INFLUXDB_LICENSE_FILES = LICENSE

$(eval $(python-package))
