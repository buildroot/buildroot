################################################################################
#
# python-redis
#
################################################################################

PYTHON_REDIS_VERSION = 8.1.0
PYTHON_REDIS_SOURCE = redis-$(PYTHON_REDIS_VERSION).tar.gz
PYTHON_REDIS_SITE = https://files.pythonhosted.org/packages/a8/99/604f0b666d4c616d891cf77ebb9db6bb21601344c051aebf1b72b9ff915f
PYTHON_REDIS_SETUP_TYPE = hatch
PYTHON_REDIS_LICENSE = MIT
PYTHON_REDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
