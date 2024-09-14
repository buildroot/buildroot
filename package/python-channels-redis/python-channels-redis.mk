################################################################################
#
# python-channels-redis
#
################################################################################

PYTHON_CHANNELS_REDIS_VERSION = 4.2.0
PYTHON_CHANNELS_REDIS_SOURCE = channels_redis-$(PYTHON_CHANNELS_REDIS_VERSION).tar.gz
PYTHON_CHANNELS_REDIS_SITE = https://files.pythonhosted.org/packages/fd/c8/d8e4d369a4cbce5dc86e84a559993001d471327f1ef57c13ffc82bdc9efa
PYTHON_CHANNELS_REDIS_SETUP_TYPE = setuptools
PYTHON_CHANNELS_REDIS_LICENSE = BSD-3-Clause
PYTHON_CHANNELS_REDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
