################################################################################
#
# python-redis
#
################################################################################

PYTHON_REDIS_VERSION = 5.0.1
PYTHON_REDIS_SOURCE = redis-$(PYTHON_REDIS_VERSION).tar.gz
PYTHON_REDIS_SITE = https://files.pythonhosted.org/packages/4a/4c/3c3b766f4ecbb3f0bec91ef342ee98d179e040c25b6ecc99e510c2570f2a
PYTHON_REDIS_SETUP_TYPE = setuptools
PYTHON_REDIS_LICENSE = MIT
PYTHON_REDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
