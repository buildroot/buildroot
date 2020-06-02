################################################################################
#
# python-redis
#
################################################################################

PYTHON_REDIS_VERSION = 3.5.2
PYTHON_REDIS_SOURCE = redis-$(PYTHON_REDIS_VERSION).tar.gz
PYTHON_REDIS_SITE = https://files.pythonhosted.org/packages/08/ca/549a324a6a40611ac6d6192586ca562e79db86dd25fa59c3877ce69ce910
PYTHON_REDIS_SETUP_TYPE = setuptools
PYTHON_REDIS_LICENSE = MIT
PYTHON_REDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
