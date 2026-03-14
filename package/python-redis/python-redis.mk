################################################################################
#
# python-redis
#
################################################################################

PYTHON_REDIS_VERSION = 7.3.0
PYTHON_REDIS_SOURCE = redis-$(PYTHON_REDIS_VERSION).tar.gz
PYTHON_REDIS_SITE = https://files.pythonhosted.org/packages/da/82/4d1a5279f6c1251d3d2a603a798a1137c657de9b12cfc1fba4858232c4d2
PYTHON_REDIS_SETUP_TYPE = hatch
PYTHON_REDIS_LICENSE = MIT
PYTHON_REDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
