################################################################################
#
# python-redis
#
################################################################################

PYTHON_REDIS_VERSION = 3.5.1
PYTHON_REDIS_SOURCE = redis-$(PYTHON_REDIS_VERSION).tar.gz
PYTHON_REDIS_SITE = https://files.pythonhosted.org/packages/1c/74/4d3250366bd783f9907d8ed32140bf4beef11000200d7edf8245800e6c4c
PYTHON_REDIS_SETUP_TYPE = setuptools
PYTHON_REDIS_LICENSE = MIT
PYTHON_REDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
