################################################################################
#
# python-redis
#
################################################################################

PYTHON_REDIS_VERSION = 5.2.0
PYTHON_REDIS_SOURCE = redis-$(PYTHON_REDIS_VERSION).tar.gz
PYTHON_REDIS_SITE = https://files.pythonhosted.org/packages/53/17/2f4a87ffa4cd93714cf52edfa3ea94589e9de65f71e9f99cbcfa84347a53
PYTHON_REDIS_SETUP_TYPE = setuptools
PYTHON_REDIS_LICENSE = MIT
PYTHON_REDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
