################################################################################
#
# python-redis
#
################################################################################

PYTHON_REDIS_VERSION = 5.0.8
PYTHON_REDIS_SOURCE = redis-$(PYTHON_REDIS_VERSION).tar.gz
PYTHON_REDIS_SITE = https://files.pythonhosted.org/packages/48/10/defc227d65ea9c2ff5244645870859865cba34da7373477c8376629746ec
PYTHON_REDIS_SETUP_TYPE = setuptools
PYTHON_REDIS_LICENSE = MIT
PYTHON_REDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
