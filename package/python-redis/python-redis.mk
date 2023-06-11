################################################################################
#
# python-redis
#
################################################################################

PYTHON_REDIS_VERSION = 4.5.5
PYTHON_REDIS_SOURCE = redis-$(PYTHON_REDIS_VERSION).tar.gz
PYTHON_REDIS_SITE = https://files.pythonhosted.org/packages/53/30/128c5599bc3fa61488866be0228326b3e486be34480126f70e572043adf8
PYTHON_REDIS_SETUP_TYPE = setuptools
PYTHON_REDIS_LICENSE = MIT
PYTHON_REDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
