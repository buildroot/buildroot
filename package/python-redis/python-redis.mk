################################################################################
#
# python-redis
#
################################################################################

PYTHON_REDIS_VERSION = 5.1.1
PYTHON_REDIS_SOURCE = redis-$(PYTHON_REDIS_VERSION).tar.gz
PYTHON_REDIS_SITE = https://files.pythonhosted.org/packages/e0/58/dcf97c3c09d429c3bb830d6075322256da3dba42df25359bd1c82b442d20
PYTHON_REDIS_SETUP_TYPE = setuptools
PYTHON_REDIS_LICENSE = MIT
PYTHON_REDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
