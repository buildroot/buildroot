################################################################################
#
# python-channels-redis
#
################################################################################

PYTHON_CHANNELS_REDIS_VERSION = 4.0.0
PYTHON_CHANNELS_REDIS_SOURCE = channels_redis-$(PYTHON_CHANNELS_REDIS_VERSION).tar.gz
PYTHON_CHANNELS_REDIS_SITE = https://files.pythonhosted.org/packages/8a/8d/bf96c62e3ca6c5ae59eb3482804afbe026c1c98b05b3ab65a0d46663644a
PYTHON_CHANNELS_REDIS_SETUP_TYPE = setuptools
PYTHON_CHANNELS_REDIS_LICENSE = BSD-3-Clause
PYTHON_CHANNELS_REDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
