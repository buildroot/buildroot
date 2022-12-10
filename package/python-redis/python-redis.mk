################################################################################
#
# python-redis
#
################################################################################

PYTHON_REDIS_VERSION = 4.4.0
PYTHON_REDIS_SOURCE = redis-$(PYTHON_REDIS_VERSION).tar.gz
PYTHON_REDIS_SITE = https://files.pythonhosted.org/packages/7a/05/671367bb466b3301bc4543fdad6ac107214ca327c8d97165b30246d87e88
PYTHON_REDIS_SETUP_TYPE = setuptools
PYTHON_REDIS_LICENSE = MIT
PYTHON_REDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
